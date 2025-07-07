import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuelmate/constants/assets.dart';
import 'package:fuelmate/view/addfuel_screen/add_fuel_screen.dart';
import 'package:fuelmate/view/addtrip_screen/addtrip_screen.dart';
import 'package:fuelmate/view/ads/custom_banner_ad.dart';
import 'package:fuelmate/view/global_widgets/custom_appbar.dart';
import 'package:fuelmate/view/navigation_bars/drawer.dart';
import 'package:fuelmate/view/home_screen/widgets/options.dart';
import 'package:fuelmate/view/home_screen/widgets/recenttrip_card.dart';
import 'package:fuelmate/view/home_screen/widgets/vehiclecard.dart';
import 'package:fuelmate/view/tripsummary_screen/trip_summary.dart';
import 'package:fuelmate/view/vehicle_screens/addvehicle.dart';
import 'package:fuelmate/viewmodel/bottombar_controller.dart';
import 'package:fuelmate/viewmodel/theme_controller.dart';
import 'package:fuelmate/viewmodel/trip_controller.dart';
import 'package:fuelmate/viewmodel/user_model.dart';
import 'package:fuelmate/viewmodel/vehicle_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int isSelected = 0;
  final controller = Get.find<ThemeController>();
  bool _showAddProfile = true;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final List<Map<String, dynamic>> optionItems = [
    {
      'img': Assets.vehicle,
      'tag': 'Add Vehicle',
      'onpress': () {
        Get.to(const AddVehicleScreen());
      },
    },
    {
      'img': Assets.trip,
      'tag': 'Add New Trip',
      'onpress': () => Get.to(() => const AddTripScreen()),
    },

    {
      'img': Assets.fuel,
      'tag': 'Add Fuel',
      'onpress': () => Get.to(() => const AddFuelScreen()),
    },
  ];
  final tripController = Get.find<TripController>();
  final userController = Get.find<UserController>();
  @override
  void initState() {
    super.initState();
    _checkProfileStatus();
  }

  void _checkProfileStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isCompleted = prefs.getBool('profileCompleted') ?? false;

    setState(() {
      _showAddProfile = !isCompleted;
    });
  }



  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      key: _key,
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            final vehicleController = Get.find<VehicleController>();
            vehicleController.update();
            setState(() {});
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///AppBar
                Padding(
                  padding: EdgeInsets.only(
                      top: 5.h, left: 16.w, right: 16.w, bottom: 5),
                  child: Custom_AppBar(
                    title: 'Home',
                    ishome: true,
                    onpressed: () {
                      _key.currentState!.openDrawer();
                    },
                    ic: Icons.person,
                    onpressed1: () {
                      final controller = Get.find<BottomBarController>();
                      controller.changeTab(3);
                    },
                  ),
                ),

                ///Ticker
                if (_showAddProfile == true)
                  Container(
                    width: double.infinity,
                    color: theme.primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Click to Complete Your profile!',
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('profileCompleted', true);
                            final controller = Get.find<BottomBarController>();
                            controller.changeTab(3);
                          },
                          child:
                              Text('Add Now', style: theme.textTheme.bodySmall),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),

                      ///Welcome Text
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'Hi!',
                                  style: theme.textTheme.bodyMedium),
                              TextSpan(
                                  text: " ${userController.user?.fullName.capitalizeFirst ?? ''}",
                                  style: GoogleFonts.poppins(
                                      color: theme.colorScheme.primary,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.sp))
                            ]),
                          ),

                          ///Change mode
                  Obx(() {
                    final isDark = controller.isDarkMode.value;
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (isDark) controller.toggleTheme();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                              decoration: BoxDecoration(
                                color: !isDark ? colorScheme.primary : theme.scaffoldBackgroundColor,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                              ),
                              child: Icon(Icons.sunny,
                                  color: !isDark ? theme.scaffoldBackgroundColor : colorScheme.primary),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (!isDark) controller.toggleTheme();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                              decoration: BoxDecoration(
                                color: isDark ? colorScheme.primary : theme.scaffoldBackgroundColor,
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                              ),
                              child: Icon(CupertinoIcons.moon,
                                  color: isDark ? theme.scaffoldBackgroundColor : colorScheme.primary),
                            ),
                          ),
                        ],
                      ),
                    );
                  })
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),

                      ///Vehicle Card
                      Vehiclecard(),
                      SizedBox(
                        height: 20.h,
                      ),

                      ///Vehicle options
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: optionItems.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 10.h,
                          childAspectRatio: 0.9,
                        ),
                        itemBuilder: (context, index) {
                          final item = optionItems[index];
                          return Options(
                            onpress: item['onpress'],
                            Img: item['img']!,
                            Tag: item['tag']!,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),

                      ///Recent Trips
                      Text(
                        textAlign: TextAlign.start,
                        "Recent Added Trips!",
                        style: theme.textTheme.bodyMedium,
                      ),
                      SizedBox(height: 10.h,),
                      Obx(() {
                        final tripList = tripController.trips;
                        if (tripList.isEmpty) {
                          return Center(child: Column(
                            children: [Text("No trips recorded yet.", style: theme.textTheme.bodySmall),
                            SizedBox(height: 10.h,)],
                          ));

                        }
                        return ListView.builder(
                          itemCount: tripList.length > 2 ? 2 : tripList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {

                            final trip = tripList.reversed.toList()[index]; // latest first

                            return Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: GestureDetector(
                                  onTap: (){
                                    Get.to(() => TripSummaryScreen(trip: trip));
                                  },
                                  child: TripSummaryCard(trip: trip)),
                            );
                          },
                        );
                      }),
                      //Banner
                      const VBanner(),
                      SizedBox(
                        height: 20.h,
                      ),
                      const CustomBannerAd(),
                      SizedBox(
                        height: 5.h,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
