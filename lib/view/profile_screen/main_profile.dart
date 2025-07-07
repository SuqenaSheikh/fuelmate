import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuelmate/constants/assets.dart';
import 'package:fuelmate/view/navigation_bars/drawer.dart';
import 'package:fuelmate/view/profile_screen/widget/editprofile.dart';
import 'package:fuelmate/viewmodel/bottombar_controller.dart';
import 'package:fuelmate/viewmodel/user_model.dart';
import 'package:get/get.dart';

import '../global_widgets/custom_appbar.dart';

class MainProfile extends StatefulWidget {
  const MainProfile({super.key});

  @override
  State<MainProfile> createState() => _MainProfileState();
}

class _MainProfileState extends State<MainProfile> {
  bool _isEditing = false;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final UserController userController = Get.find<UserController>();

  void _toggleEditing(bool editing) {
    setState(() {
      _isEditing = editing;
    });
  }

  Map<String, String> get displayData {
    final user = userController.user;
    return {
      "Full Name": user?.fullName ?? "Tayyaba Shahid",
      "Email": user?.email ?? "tayyaba@email.com",
      "Phone Number": user?.phone ?? "0300-1234567",
      "Age": user?.age ?? "22",
      "Gender": user?.gender ?? "Female",
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: _key,
        drawer: const CustomDrawer(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 5.h, right: 16.w, left: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Custom_AppBar(
                    title: 'Profile',
                    ishome: true,
                    onpressed: () => _key.currentState!.openDrawer(),
                    ic: Icons.home,
                    onpressed1: () => Get.find<BottomBarController>().changeTab(0),
                  ),
                  SizedBox(height: 20.h),
                  _toggleButtons(theme),
                  SizedBox(height: 30.h),
                  _isEditing ? ProfileScreen(onSaved: () => _toggleEditing(false)) : _buildViewProfile(theme),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _toggleButtons(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.primary),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          _toggleButton("Profile", !_isEditing, () => _toggleEditing(false), theme),
          _toggleButton("Edit", _isEditing, () => _toggleEditing(true), theme),
        ],
      ),
    );
  }

  Widget _toggleButton(String label, bool isSelected, VoidCallback onTap, ThemeData theme) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: isSelected ? theme.colorScheme.primary : Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: label == "Profile" ? const Radius.circular(10) : Radius.zero,
              bottomLeft: label == "Profile" ? const Radius.circular(10) : Radius.zero,
              topRight: label == "Edit" ? const Radius.circular(10) : Radius.zero,
              bottomRight: label == "Edit" ? const Radius.circular(10) : Radius.zero,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? theme.scaffoldBackgroundColor : theme.colorScheme.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildViewProfile(ThemeData theme) {
    final user = userController.user;
    final imagePath = user?.imagePath;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: SizedBox(
            height: 120,
            width: 120,
            child: ClipOval(
              child: imagePath != null && File(imagePath).existsSync()
                  ? Image.file(File(imagePath), fit: BoxFit.cover)
                  : Image.asset(Assets.user, fit: BoxFit.cover),
            ),
          ),
        ),
        SizedBox(height: 30.h),
        ...displayData.entries.map((entry) {
          return Padding(
            padding: EdgeInsets.only(bottom: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.key, style: theme.textTheme.bodyMedium),
                SizedBox(height: 5.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10.h),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(entry.value, style: theme.textTheme.bodySmall),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

