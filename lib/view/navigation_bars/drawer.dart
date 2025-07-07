import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fuelmate/view/default_vehicle/default_vehicle.dart';
import 'package:fuelmate/view/history_screens/fuelhistory.dart';
import 'package:fuelmate/view/history_screens/triphistory.dart';
import 'package:fuelmate/viewmodel/bottombar_controller.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Drawer(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
        
            children: [
            //   SizedBox(height: 20.h),
            //   Text('FuelMate', style: theme.textTheme.bodyLarge),
            // //  Divider(color: theme.dividerColor),
            //   SizedBox(height: 10.h),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTile(
                      icon: Icons.local_gas_station,
                      label: 'Fuel History',
                      onTap: () => Get.to(() => const FuelHistoryScreen() ), // Replace with actual screen
                    ),
                    _buildTile(
                      icon: Icons.route,
                      label: 'Trip History',
                      onTap: () => Get.to(() => const TripHistoryScreen()),
                    ),
                    _buildTile(
                      icon: Icons.directions_car,
                      label: 'Default Vehicle',
                      onTap: () => Get.to(() => const DefaultVehicleScreen()),
                    ),
                    _buildTile(
                      icon: Icons.settings,
                      label: 'Settings',
                      onTap: (){
                        final controller = Get.find<BottomBarController>();
                        controller.changeTab(2);
                        Get.back();
                      },
                    ),
                    _buildTile(
                      icon: Icons.share,
                      label: 'Share App',
                      onTap: () {} //launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=com.fuelmate')),
                    ),
                    _buildTile(
                      icon: Icons.star_rate,
                      label: 'Rate Us',
                      onTap: () {}//launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=com.fuelmate')),
                    ),
                  ],
                ),
              ),
        
        
        
        
        
              Text('Follow us', style: theme.textTheme.bodySmall),
              SizedBox(height: 10.h),
              Row(
                children: [
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
                    onPressed: () async {
                    //  await launchUrl(Uri.parse('https://facebook.com/yourpage'), mode: LaunchMode.externalApplication);
                    },
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.instagram, color: Colors.pink),
                    onPressed: () async {
                     // await launchUrl(Uri.parse('https://instagram.com/yourprofile'), mode: LaunchMode.externalApplication);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTile({required IconData icon, required String label, required VoidCallback onTap}) {
    final theme = Theme.of(Get.context!);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon,color: theme.primaryColor),
      title: Text(label,style:theme.textTheme.bodyMedium),
      onTap: onTap,
    );
  }
}
