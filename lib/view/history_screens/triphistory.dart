import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuelmate/view/global_widgets/custom_appbar.dart';
import 'package:fuelmate/view/tripsummary_screen/trip_summary.dart';
import 'package:fuelmate/viewmodel/trip_controller.dart';
import 'package:get/get.dart';

class TripHistoryScreen extends StatelessWidget {
  const TripHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tripController = Get.find<TripController>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Custom_AppBar(title: 'Trip History'),
              SizedBox(height: 20.h),

              Obx(() {
                final trips = tripController.trips;
                if (trips.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Text('No trip history found.', style: theme.textTheme.bodyMedium),
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: trips.length,
                    itemBuilder: (context, index) {
                      final trip = trips[index];
                      return GestureDetector(
                        onTap: (){
                          Get.to(() => TripSummaryScreen(trip: trip));
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 12.h),
                          padding: EdgeInsets.all(14.w),
                          decoration: BoxDecoration(
                            color: theme.cardColor,
                            borderRadius: BorderRadius.circular(12.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.directions_car, color: theme.colorScheme.primary),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: Text(
                                      trip.tripName,
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    trip.tripType,
                                    style: theme.textTheme.titleSmall?.copyWith(color: Colors.grey),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.date_range, size: 18.sp, color: Colors.grey),
                                      SizedBox(width: 5.w),
                                      Text(trip.date, style: theme.textTheme.bodySmall),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.social_distance, size: 18.sp, color: Colors.grey),
                                      SizedBox(width: 5.w),
                                      Text('${trip.distance.toStringAsFixed(1)} km', style: theme.textTheme.bodySmall),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
