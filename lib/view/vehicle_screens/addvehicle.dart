import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuelmate/constants/assets.dart';
import 'package:fuelmate/view/global_widgets/custom_Appbar.dart';
import 'package:fuelmate/view/global_widgets/custom_button.dart';
import 'package:fuelmate/view/global_widgets/custom_dropdown.dart';
import 'package:fuelmate/view/global_widgets/custom_textfield.dart';
import 'package:fuelmate/viewmodel/vehicle_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _makeController = TextEditingController();
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  final _plateController = TextEditingController();

  // Dropdown values
  String? _fuelType;
  String? _transmission;
  String? _vehicletype;

  final List<String> fuelTypes = ['Petrol', 'Diesel', 'Electric', 'Hybrid'];
  final List<String> transmissions = ['Manual', 'Automatic'];
  final List<String> vehicletype = ['Car', 'MotorBike', 'Bus', 'Truck'];
  //Image Picker
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }
  void _removeImage() {
    setState(() => _selectedImage = null);
  }

  @override
  void dispose() {
    _makeController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _plateController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final controller = Get.find<VehicleController>();

      controller.addVehicle(
        brand: _makeController.text.trim(),
        model: '',
        imagePath: _selectedImage?.path ?? Assets.dummycar, // use dummy if not selected
        year: _yearController.text.trim(),
        licensePlate: _plateController.text.trim(),
        fuelType: _fuelType,
        transmission: _transmission,
        vehicleType: _vehicletype,
      );

      Get.back(); // or navigate wherever appropriate
      Get.snackbar("Success", "Vehicle added successfully",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      // Hide keyboard on tap outside
      child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
                    child: Padding(
            padding: EdgeInsets.only(top: 20.h, right: 16.w, left: 16.w, bottom: 20),
            child: Column(
              children: [
                Custom_AppBar(title: 'Add Vehicle'),
                SizedBox(height:30.h),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                    GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 100.w,
                      height: 90.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: theme.primaryColor),
                        borderRadius: BorderRadius.circular(12.r),
                        image: _selectedImage != null
                            ? DecorationImage(
                          image: FileImage(_selectedImage!),
                          fit: BoxFit.cover,
                        )
                            : null,
                      ),
                      child: _selectedImage == null
                          ? Center(
                        child: Icon(Icons.camera_alt, color: theme.primaryColor, size: 32),
                      )
                          : Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: _removeImage,
                        ),
                      ),
                    ),
                  ),

                      SizedBox(height: 20.h),
                      CustomDropdown(
                          label: "Vehicle Type", value: _vehicletype, items:vehicletype,
                          onChanged:(value) {
                            setState(() => _vehicletype = value);
                          }),
                      SizedBox(height: 10.h),

                      CustomTextField(
                         controller:  _makeController,label:  "Brand", hint: "Enter vehicle name",
                        validator: (value) => value == null || value.trim().isEmpty ? "Brand is required" : null,
                      ),
                      SizedBox(height: 10.h),
                      // CustomTextField(
                      //     controller:_modelController,label: "Model", hint:"Enter vehicle model",
                      //   validator: (value) => value == null || value.trim().isEmpty ? "Date is required" : null,),

                      CustomTextField(
                       controller: _yearController,
                        label: "Model",
                       hint: "Enter vehicle model",
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        validator: (value) => value == null || value.trim().isEmpty ? "Brand is required" : null,
                      ),
                      CustomDropdown(
                          label: "Fuel Type", value: _fuelType, items:fuelTypes,
                          onChanged: (value) {
                        setState(() => _fuelType = value);
                      }),
                      SizedBox(height: 10.h),
                     CustomDropdown(
                          label: "Transmission", value: _transmission, items:transmissions,
                         onChanged:(value) {
                        setState(() => _transmission = value);
                      }),
                      SizedBox(height: 10.h),
                      CustomTextField(
                          controller:_plateController, label:"License Plate (Optional)",
                          hint: "Enter license plate"),

                      SizedBox(height: 30.h),
                      Custom_Button(
                          font: 12,
                          title: 'Add Vehicle',
                          wid: double.infinity,
                          BoxColor: theme.primaryColor,
                          BorderColor: theme.primaryColor,
                          TextColor: theme.scaffoldBackgroundColor,
                          onPressed: _submitForm)
                    ],
                  ),
                ),
              ],
            ),
                    ),
                  ),
          )),
    );
  }
}
