import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuelmate/constants/assets.dart';
import 'package:fuelmate/constants/theme.dart';
import 'package:fuelmate/view/vehicle_screens/single_vehicle.dart';
import 'package:fuelmate/viewmodel/fuel_controller.dart';
import 'package:fuelmate/viewmodel/vehicle_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Vehiclecard extends StatelessWidget {
  Vehiclecard({super.key});

  final VehicleController vehicleController = Get.find<VehicleController>();
  final FuelController fuelController = Get.find<FuelController>();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gradient = isDark
        ? AppThemes.darkCardGradient
        : AppThemes.lightCardGradient;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GetBuilder<VehicleController>(
      builder: (vehicleController) {
        final defaultVehicle = vehicleController.defaultVehicle;

        if (defaultVehicle == null) {
          return const SizedBox(); // or a message
        }

        final vehicleName = '${defaultVehicle.brand} ${defaultVehicle.model}';
        final latestFuel = fuelController.fuelList
            .where((fuel) => fuel.vehicleName == vehicleName)
            .toList()
            .reversed
            .firstOrNull;

        final isAsset = defaultVehicle.imagePath == Assets.dummycar;
        final image = isAsset
            ? AssetImage(defaultVehicle.imagePath)
            : FileImage(File(defaultVehicle.imagePath)) as ImageProvider;

        return GestureDetector(
          onTap: (){
            Get.to(() => SingleVehicleScreen(vehicle: defaultVehicle));
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "Default",
                    style: GoogleFonts.poppins(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(vehicleName, style: theme.textTheme.bodyMedium),
                        Text(
                          latestFuel != null
                              ? 'Last Fuel-up: ${latestFuel.liters} L @ Rs. ${latestFuel.pricePerLiter}'
                              : 'No fuel-up yet',
                          style: theme.textTheme.bodySmall,
                        ),
                        Text(
                          latestFuel?.date ?? '',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}



