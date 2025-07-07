import 'package:flutter/material.dart';
import 'package:fuelmate/view/vehicle_screens/added_vahicles.dart';
import 'package:fuelmate/view/home_screen/home.dart';
import 'package:fuelmate/view/profile_screen/main_profile.dart';
import 'package:fuelmate/view/settings/settings.dart';
import 'package:fuelmate/viewmodel/bottombar_controller.dart';
import 'package:get/get.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomBarController controller = Get.put(BottomBarController());

    final List<Widget> screens = [
      const HomeScreen(),
      AllVehiclesScreen(),
      SettingsScreen(),
      const MainProfile(),
    ];

    const List<BottomNavigationBarItem> navItems = [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.directions_car), label: 'Vehicles'),
      BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    ];

    return Obx(() => Scaffold(
      body: screens[controller.selectedIndex.value],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: controller.selectedIndex.value,
        onTap: controller.changeTab,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).iconTheme.color,
        items: navItems,
      ),
    ));
  }
}
