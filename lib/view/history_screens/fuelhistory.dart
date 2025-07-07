import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuelmate/view/global_widgets/custom_appbar.dart';
import 'package:fuelmate/viewmodel/fuel_controller.dart';
import 'package:get/get.dart';

class FuelHistoryScreen extends StatelessWidget {
  const FuelHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final FuelController controller = Get.find();
    // final List<Map<String, String>> fuelEntries = [
    //   {
    //     'vehicle': 'Toyota Corolla 2020',
    //     'liters': '32',
    //     'amount': 'PKR 8,960',
    //     'date': '01 July 2025',
    //   },
    //   {
    //     'vehicle': 'Honda Civic 2019',
    //     'liters': '20',
    //     'amount': 'PKR 5,600',
    //     'date': '28 June 2025',
    //   },
    //   {
    //     'vehicle': 'Suzuki Alto 2021',
    //     'liters': '25',
    //     'amount': 'PKR 7,000',
    //     'date': '25 June 2025',
    //   },
    // ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Custom_AppBar(title: 'Fuel History'),
              SizedBox(height: 20.h),

              Obx(() => controller.fuelList.isEmpty
                  ? Expanded(child: Center(child: Text('No fuel history available.', style: theme.textTheme.bodyMedium)))
                  : Expanded(
                child: ListView.builder(
                  itemCount: controller.fuelList.length,
                  itemBuilder: (context, index) {
                    final fuel = controller.fuelList[index];
                    return Container(
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
                          Text(fuel.vehicleName, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.local_gas_station, size: 18.sp, color: theme.colorScheme.primary),
                                  SizedBox(width: 6.w),
                                  Text('${fuel.liters} L', style: theme.textTheme.bodySmall),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.monetization_on, size: 18.sp, color: Colors.grey),
                                  SizedBox(width: 6.w),
                                  Text('PKR ${fuel.totalCost}', style: theme.textTheme.bodySmall),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 6.h),
                          Row(
                            children: [
                              Icon(Icons.calendar_today, size: 18.sp, color: Colors.grey),
                              SizedBox(width: 6.w),
                              Text(fuel.date, style: theme.textTheme.bodySmall),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
