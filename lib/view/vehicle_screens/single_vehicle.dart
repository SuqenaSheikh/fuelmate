import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuelmate/constants/assets.dart';
import 'package:fuelmate/constants/theme.dart';
import 'package:fuelmate/model/vehicle_model.dart';
import 'package:fuelmate/view/global_widgets/custom_Appbar.dart';

class SingleVehicleScreen extends StatelessWidget {
  final VehicleModel vehicle;

  const SingleVehicleScreen({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final image = vehicle.imagePath.isNotEmpty
        ? FileImage(File(vehicle.imagePath))
        : const AssetImage(Assets.dummycar) as ImageProvider;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            children: [
              Custom_AppBar(title: 'Vehicle Details'),
              SizedBox(
                height: 30.h,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Decorative Icons Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _vehicleIcon(Icons.local_gas_station, vehicle.fuelType),
                        _vehicleIcon(Icons.directions_car, vehicle.vehicleType),
                        _vehicleIcon(Icons.settings, vehicle.transmission),
                      ],
                    ),

                    SizedBox(height: 50.h),

                    // Details Card
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          children: [
                            _infoRow('Brand', vehicle.brand),
                            _infoRow('Model', vehicle.year),
                            _infoRow('Fuel Type', vehicle.fuelType),
                            _infoRow('Transmission', vehicle.transmission),
                            _infoRow('Vehicle Type', vehicle.vehicleType),
                            _infoRow(
                              'License Plate',
                              vehicle.licensePlate.isEmpty
                                  ? 'N/A'
                                  : vehicle.licensePlate,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _vehicleIcon(IconData iconPath, String label) {
    return Column(
      children: [
        Icon(
          iconPath,
          color: AppThemes.primaryColor,
          size: 32.sp,
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
