import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuelmate/view/global_widgets/custom_Appbar.dart';
import 'package:fuelmate/view/navigation_bars/drawer.dart';
import 'package:fuelmate/view/settings/notification.dart';
import 'package:fuelmate/view/settings/privacypolicy.dart';
import 'package:fuelmate/view/settings/themeswitch.dart';
import 'package:fuelmate/viewmodel/bottombar_controller.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      key: _key,
      drawer: const CustomDrawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Custom_AppBar(title: 'Settings', ishome: true, onpressed: (){
              _key.currentState!.openDrawer();
            },),
            SizedBox(height: 20.h,),
            /// Account
            _sectionTitle("Account", theme),
            _settingTile(
              icon: Icons.person_outline,
              title: "Edit Profile",
              onTap: () {
                // Navigate to profile edit screen
                final controller = Get.find<BottomBarController>();
                controller.changeTab(3);
              },
            ),
            // _settingTile(
            //   icon: Icons.lock_outline,
            //   title: "Change Password",
            //   onTap: () {
            //     // Get.to(() => const ChangePasswordScreen());
            //   },
            // ),

            SizedBox(height: 20.h),

            /// Preferences
            _sectionTitle("Preferences", theme),
            _settingTile(
              icon: Icons.palette_outlined,
              title: "Theme",
              onTap: () {
                Get.to(()=>ThemeScreen());
              },
            ),
            _settingTile(
              icon: Icons.notifications_none,
              title: "Notifications",
              onTap: () => Get.to(() => const NotificationScreen())
            ),

            SizedBox(height: 20.h),

            /// About
            _sectionTitle("Support", theme),
            _settingTile(
              icon: Icons.privacy_tip_outlined,
              title: "Privacy Policy",
              onTap: () => Get.to(()=>const PrivacyPolicy())
            ),
            _settingTile(
              icon: Icons.support_agent,
              title: "Contact Support",
              onTap: () {
                // launch email or support screen
              },
            ),
            _settingTile(
              icon: Icons.info_outline,
              title: "App Version",
              trailing: Text("v1.0.0", style: theme.textTheme.bodySmall),
              onTap: () {},
            ),

            const Spacer(),

            Center(
              child: Text(
                "FuelMate © 2025",
                style: theme.textTheme.bodySmall!.copyWith(color: Colors.grey),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, ThemeData theme) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Text(title, style: theme.textTheme.titleSmall),
    );
  }

  Widget _settingTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    final theme = Theme.of(Get.context!);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: theme.primaryColor),
      title: Text(title,style:theme.textTheme.bodyMedium),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios_rounded, size: 14),
      onTap: onTap,
    );
  }
}
