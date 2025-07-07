import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fuelmate/view/navigation_bars/bottom_bar.dart';
import 'package:fuelmate/view/welcome_screens/onboarding.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  // void checkLoginStatus() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  //
  //   await Future.delayed(Duration(seconds: 3));
  //
  //   if (isLoggedIn) {
  //     Get.offAll(() => BottomBAr());
  //   } else {
  //     Get.offAllNamed('/Onboarding1');
  //   }
  // }
  // @override
  // void initState() {
  //   super.initState();
  //   checkLoginStatus();
  // }
  @override
  @override
  void initState() {
    super.initState();
    _navigateUser();
  }
  Future<void> _navigateUser() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('isFirstTime') ?? true;

    await Future.delayed(const Duration(seconds: 2));

    if (isFirstTime) {
      prefs.setBool('isFirstTime', false);
      Get.off(() => const Onboarding());
    } else {
      Get.off(() => const BottomBar());
    }
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(

      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 1000),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.scale(
                scale: 0.8 + 0.2 * value, // from 0.8 to 1.0
                child: child,
              ),
            );
          },
          child: Text(
            "Welcome to FuelMate!",
            style: theme.textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}