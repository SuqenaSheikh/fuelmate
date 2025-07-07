import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuelmate/model/trip_model.dart';
import 'package:fuelmate/view/global_widgets/custom_Appbar.dart';
import 'package:fuelmate/viewmodel/fuel_controller.dart';
import 'package:fuelmate/viewmodel/vehicle_controller.dart';
import 'package:get/get.dart';

class TripSummaryScreen extends StatelessWidget {
  final NewTripModel trip;

  const TripSummaryScreen({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    final vehicleController = Get.find<VehicleController>();
    final fuelController = Get.find<FuelController>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final defaultVehicle = vehicleController.defaultVehicle;
    final vehicleName = '${defaultVehicle?.brand ?? ''} ${defaultVehicle?.model ?? ''}';

    final latestFuel = fuelController.fuelList
        .where((f) => f.vehicleName == vehicleName)
        .toList()
        .reversed
        .firstOrNull;

    final currentFuel = latestFuel?.liters ?? 0.0;
    final pricePerLiter = latestFuel?.pricePerLiter ?? 0.0;

    final mileage = trip.mileage;
    final requiredFuel = trip.distance / (mileage == 0 ? 1 : mileage);
    final additionalFuel = (requiredFuel - currentFuel).clamp(0.0, double.infinity);

    final totalCost = additionalFuel * pricePerLiter;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Custom App Bar
              Custom_AppBar(title: 'Trip Summary'),

              SizedBox(height: 25.h),

              /// Card UI
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Trip Title
                    Text(
                      'Trip Destination',
                      style: theme.textTheme.bodySmall!.copyWith(color: Colors.grey),
                    ),
                    Text(
                      trip.tripName,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    _infoRow('Distance to Travel', '${trip.distance.toStringAsFixed(1)} km', theme),
                    _infoRow('Vehicle Mileage', '${mileage.toStringAsFixed(1)} km/l', theme),
                    _infoRow('Current Fuel in Tank', '${currentFuel.toStringAsFixed(1)} L', theme),
                    _infoRow('Fuel Required', '${requiredFuel.toStringAsFixed(2)} L', theme),
                    _infoRow(
                      'Additional Fuel Needed',
                      '${additionalFuel.toStringAsFixed(2)} L',
                      theme,
                      highlight: true,
                      highlightColor: additionalFuel > 0
                          ? Colors.red
                          : colorScheme.primary,
                    ),
                    if (additionalFuel > 0 && pricePerLiter > 0)
                      _infoRow(
                        'Estimated Fuel Cost',
                        'Rs. ${totalCost.toStringAsFixed(2)}',
                        theme,
                        highlight: true,
                        highlightColor: additionalFuel > 0
                            ? Colors.red
                            : colorScheme.primary,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Helper Widget for displaying info rows
  Widget _infoRow(String title, String value, ThemeData theme,
      {bool highlight = false, Color? highlightColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: theme.textTheme.bodySmall),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: highlight ? highlightColor ?? Colors.red : null,
            ),
          ),
        ],
      ),
    );
  }
}
