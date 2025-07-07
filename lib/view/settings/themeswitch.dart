import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuelmate/view/global_widgets/custom_Appbar.dart';
import 'package:fuelmate/viewmodel/theme_controller.dart';
import 'package:get/get.dart';

class ThemeScreen extends StatelessWidget {
  ThemeScreen({super.key});

  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height:40.h),
            Custom_AppBar(title: 'Theme Settings'),
            SizedBox(height: 20.h),
            Text("Select Theme", style: theme.textTheme.bodyMedium),
            SizedBox(height: 20.h),
            Obx(() {
              return Row(
                children: [
                  _buildThemeOption(
                    icon: Icons.wb_sunny,
                    label: "Light",
                    isSelected: !themeController.isDarkMode.value,
                    onTap: () => themeController.isDarkMode.value = false,
                    theme: theme,
                  ),
                  SizedBox(width: 20.w),
                  _buildThemeOption(
                    icon: Icons.nights_stay,
                    label: "Dark",
                    isSelected: themeController.isDarkMode.value,
                    onTap: () => themeController.isDarkMode.value = true,
                    theme: theme,
                  ),
                ],
              );
            }),
            SizedBox(height: 40.h),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  foregroundColor: theme.scaffoldBackgroundColor,
                ),
                onPressed: () => themeController.toggleTheme(),
                icon: const Icon(Icons.brightness_6),
                label: const Text("Toggle Theme"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required ThemeData theme,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? theme.primaryColor : theme.cardColor,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: isSelected ? theme.primaryColor : theme.dividerColor,
              width: 1.5,
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon,
                    color: isSelected
                        ? theme.scaffoldBackgroundColor
                        : theme.iconTheme.color),
                SizedBox(width: 8.w),
                Text(
                  label,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: isSelected
                        ? theme.scaffoldBackgroundColor
                        : theme.textTheme.bodyMedium!.color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
