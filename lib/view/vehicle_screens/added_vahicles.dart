import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuelmate/constants/assets.dart';
import 'package:fuelmate/view/vehicle_screens/single_vehicle.dart';
import 'package:fuelmate/view/global_widgets/custom_appbar.dart';
import 'package:fuelmate/view/navigation_bars/drawer.dart';
import 'package:fuelmate/viewmodel/vehicle_controller.dart';
import 'package:get/get.dart';

class AllVehiclesScreen extends StatelessWidget {
  AllVehiclesScreen({super.key});
  final GlobalKey<ScaffoldState> _key = GlobalKey();


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      key: _key,
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Custom_AppBar(title: 'All Vehicles',ishome: true, onpressed: (){
                _key.currentState!.openDrawer();

              },),
              SizedBox(height: 20.h),
              Expanded(
                child: GetBuilder<VehicleController>(
                  builder: (controller) {
                    final vehicles = controller.allVehicles;

                    if (vehicles.isEmpty) {
                      return Center(
                        child: Text(
                          'No vehicles added yet.',
                          style: theme.textTheme.bodyMedium,
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: vehicles.length,
                      separatorBuilder: (_, __) => SizedBox(height: 12.h),
                      itemBuilder: (context, index) {
                        final vehicle = vehicles[index];
                        final isAsset = vehicle.imagePath == Assets.dummycar;

                        return GestureDetector(
                          onTap: (){
                            Get.to(()=>SingleVehicleScreen(vehicle: vehicle,));
                          },
                          child: Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: theme.cardColor,
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                )
                              ],
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: isAsset
                                      ? Image.asset(
                                    vehicle.imagePath,
                                    width: 56.w,
                                    height: 56.h,
                                    fit: BoxFit.cover,
                                  )
                                      : Image.file(
                                    File(vehicle.imagePath),
                                    width: 56.w,
                                    height: 56.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(vehicle.brand, style: theme.textTheme.bodyMedium),
                                      SizedBox(height: 4.h),
                                      Text("Model: ${vehicle.model}", style: theme.textTheme.bodySmall),
                                    ],
                                  ),
                                ),
                               // Icon(Icons.arrow_forward_ios, size: 16.sp, color: theme.iconTheme.color),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
