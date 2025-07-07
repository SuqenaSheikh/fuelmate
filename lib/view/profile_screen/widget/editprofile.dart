import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuelmate/constants/assets.dart';
import 'package:fuelmate/model/user_model.dart';
import 'package:fuelmate/view/global_widgets/custom_button.dart';
import 'package:fuelmate/view/global_widgets/custom_dropdown.dart';
import 'package:fuelmate/view/global_widgets/custom_textfield.dart';
import 'package:fuelmate/viewmodel/user_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProfileScreen extends StatefulWidget {
  final VoidCallback onSaved;
  const ProfileScreen({super.key, required this.onSaved});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();
  String? _gender;
  File? _selectedImage;
  final List<String> genders = ['Male', 'Female'];

  @override
  void initState() {
    super.initState();
    final user = Get.find<UserController>().user;
    if (user != null) {
      _fullNameController.text = user.fullName;
      _emailController.text = user.email;
      _phoneController.text = user.phone;
      _ageController.text = user.age;
      _gender = user.gender;
      if (user.imagePath != null) {
        final file = File(user.imagePath!);
        if (file.existsSync()) _selectedImage = file;
      }
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final saved = await File(picked.path).copy('${appDir.path}/${picked.name}');
      setState(() => _selectedImage = saved);
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: 120,
              width: 120,
              child: ClipOval(
                child: _selectedImage != null
                    ? Image.file(_selectedImage!, fit: BoxFit.cover)
                    : Image.asset(Assets.user, fit: BoxFit.cover),
              ),
            ),
            Positioned(
              right: 0,
              bottom: -5,
              child: IconButton(
                onPressed: _pickImage,
                icon: Icon(Icons.camera_alt, color: theme.primaryColor),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        CustomTextField(controller: _fullNameController, label: 'Full Name', hint: 'Enter Full Name'),
        SizedBox(height: 20.h),
        CustomTextField(controller: _emailController, label: 'Email', hint: 'Enter Email'),
        SizedBox(height: 20.h),
        CustomTextField(controller: _phoneController, label: 'Phone Number', hint: 'Enter Phone', keyboardType: TextInputType.phone),
        SizedBox(height: 20.h),
        CustomTextField(controller: _ageController, label: 'Age', hint: 'Enter Age', keyboardType: TextInputType.number),
        SizedBox(height: 20.h),
        CustomDropdown(
          label: "Gender",
          value: genders.contains(_gender) ? _gender : 'Female',
          items: genders,
          onChanged: (val) => setState(() => _gender = val),
        ),
        SizedBox(height: 20.h),
        Custom_Button(
          title: 'Save',
          font: 12,
          wid: double.infinity,
          BoxColor: theme.primaryColor,
          BorderColor: theme.primaryColor,
          TextColor: theme.scaffoldBackgroundColor,
          onPressed: () {
            final userController = Get.find<UserController>();
            final newUser = UserModel(
              fullName: _fullNameController.text,
              email: _emailController.text,
              phone: _phoneController.text,
              age: _ageController.text,
              gender: _gender ?? 'Female',
              imagePath: _selectedImage?.path,
            );
            userController.saveUser(newUser);
            widget.onSaved(); // Notify parent
            Get.snackbar("Success", "Profile updated");
          },
        ),
      ],
    );
  }
}

