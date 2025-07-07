import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuelmate/viewmodel/vehicle_controller.dart';
import 'package:get/get.dart';
import 'package:fuelmate/view/global_widgets/custom_appbar.dart';

class DefaultVehicleScreen extends StatefulWidget {
  const DefaultVehicleScreen({super.key});

  @override
  State<DefaultVehicleScreen> createState() => _DefaultVehicleScreenState();
}

class _DefaultVehicleScreenState extends State<DefaultVehicleScreen> {
  final String _selectedVehicleId = '1';
  final VehicleController vehicleController = Get.find();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final VehicleController vehicleController = Get.find();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Custom_AppBar(title: 'Default Vehicle'),
              SizedBox(height: 30.h),
              Text(
                'Choose your default vehicle:',
                style: theme.textTheme.bodyMedium,
              ),
              SizedBox(height: 20.h),

              /// Vehicle list
              /// Vehicle list from controller
              Expanded(
                child: GetBuilder<VehicleController>(
                  builder: (vehicleController) {
                    final vehicles = vehicleController.allVehicles;

                    if (vehicles.isEmpty) {
                      return Center(
                        child: Text(
                          'No vehicles added yet.',
                          style: theme.textTheme.bodySmall,
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: vehicles.length,
                      itemBuilder: (context, index) {
                        final vehicle = vehicles[index];

                        return Obx(() {
                          final isSelected =
                              vehicleController.defaultVehicleId.value ==
                                  vehicle.id;

                          return GestureDetector(
                            onTap: () {
                              vehicleController.setDefaultVehicle(vehicle.id);
                              Get.snackbar(
                                'Vehicle Updated',
                                '${vehicle.brand} ${vehicle.model} set as default',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 12.h),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 14.h),
                              decoration: BoxDecoration(
                                color: theme.cardColor,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: isSelected
                                      ? theme.colorScheme.primary
                                      : Colors.transparent,
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.directions_car_filled,
                                      color: theme.primaryColor, size: 28),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Text(
                                      '${vehicle.brand} ${vehicle.model} (${vehicle.year})',
                                      style: theme.textTheme.bodyMedium,
                                    ),
                                  ),
                                  Radio<String>(
                                    value: vehicle.id,
                                    groupValue: vehicleController
                                        .defaultVehicleId.value,
                                    onChanged: (value) {
                                      vehicleController
                                          .setDefaultVehicle(vehicle.id);
                                      vehicleController.update();
                                      Get.snackbar(
                                        'Vehicle Updated',
                                        '${vehicle.brand} ${vehicle.model} set as default',
                                        snackPosition: SnackPosition.BOTTOM,
                                      );
                                    },
                                    activeColor: theme.colorScheme.primary,
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                      },
                    );
                  },
                ),
              ),



              SizedBox(height: 10.h),
              Text(
                textAlign: TextAlign.center,
                'This vehicle will be used by default in fuel logs',
                style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
