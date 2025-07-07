import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuelmate/constants/theme.dart';
import 'package:fuelmate/model/fuel_entry.dart';
import 'package:fuelmate/model/trip_model.dart';
import 'package:fuelmate/model/user_model.dart';
import 'package:fuelmate/model/vehicle_model.dart';
import 'package:fuelmate/view/welcome_screens/splash.dart';
import 'package:fuelmate/viewmodel/fuel_controller.dart';
import 'package:fuelmate/viewmodel/theme_controller.dart';
import 'package:fuelmate/viewmodel/trip_controller.dart';
import 'package:fuelmate/viewmodel/user_model.dart';
import 'package:fuelmate/viewmodel/vehicle_controller.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();


  // Initialize Hive
  await Hive.initFlutter();
  // Register Hive adapters
  Hive.registerAdapter(FuelModelAdapter());
  Hive.registerAdapter(NewTripModelAdapter());
  Hive.registerAdapter(VehicleModelAdapter());
  Hive.registerAdapter(UserModelAdapter());
  // This deletes all entries in the box

  // Open Hive boxes
  await Hive.openBox<FuelModel>('fuelBox');
  await Hive.openBox<NewTripModel>('tripBox');
  await Hive.openBox<VehicleModel>('vehiclesBox');
  await Hive.openBox<UserModel>('userBox');
  // final box = Hive.box<UserModel>('userBox');
  // await box.clear();

  // Register controllers
  Get.put(ThemeController());
  Get.put(FuelController());
  Get.put(TripController());
  Get.put(VehicleController());
  Get.put(UserController());

  // Set status bar style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;

  void toggleTheme() {
    setState(() => isDark = !isDark);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => Obx(() {
        return AnimatedTheme(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          data: themeController.isDarkMode.value
              ? AppThemes.darkTheme
              : AppThemes.lightTheme,
          child: GetMaterialApp(
            title: 'Fuel Mate',
            debugShowCheckedModeBanner: false,
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: themeController.themeMode,
            home: const SplashScreen(),
          ),
        );
      }),
    );
  }
}
