import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuelmate/view/global_widgets/custom_date_widget.dart';
import 'package:fuelmate/model/fuel_entry.dart';
import 'package:fuelmate/view/global_widgets/custom_Appbar.dart';
import 'package:fuelmate/view/global_widgets/custom_button.dart';
import 'package:fuelmate/view/global_widgets/custom_dropdown.dart';
import 'package:fuelmate/view/global_widgets/custom_textfield.dart';
import 'package:fuelmate/view/vehicle_screens/addvehicle.dart';
import 'package:fuelmate/viewmodel/fuel_controller.dart';
import 'package:fuelmate/viewmodel/vehicle_controller.dart';
import 'package:get/get.dart';

class AddFuelScreen extends StatefulWidget {
  const AddFuelScreen({super.key});

  @override
  State<AddFuelScreen> createState() => _AddFuelScreenState();
}

class _AddFuelScreenState extends State<AddFuelScreen> {
  final _formKey = GlobalKey<FormState>();

  final _litersController = TextEditingController();
  final _costController = TextEditingController();
  final _pricePerLiterController = TextEditingController();
  final _odometerController = TextEditingController();
  final _dateController = TextEditingController();

  String? _selectedFuelType;
  final List<String> fuelTypes = ['Petrol', 'Diesel', 'CNG'];

  @override
  void dispose() {
    _litersController.dispose();
    _costController.dispose();
    _pricePerLiterController.dispose();
    _odometerController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _litersController.addListener(_calculateTotalCost);
    _pricePerLiterController.addListener(_calculateTotalCost);
  }
  void _calculateTotalCost() {
    final liters = double.tryParse(_litersController.text.trim());
    final price = double.tryParse(_pricePerLiterController.text.trim());

    if (liters != null && price != null) {
      final total = liters * price;
      _costController.text = total.toStringAsFixed(2);
    } else {
      _costController.clear();
    }
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Custom_AppBar(title: 'Add Fuel Entry'),
                  SizedBox(height:30.h),
                  CustomDropdown(
                    label: "Fuel Type",
                    value: _selectedFuelType,
                    items: fuelTypes,
                    onChanged: (val) => setState(() => _selectedFuelType = val),
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    controller: _litersController,
                    label: "Liters",
                    hint: "Enter fuel quantity",
                    keyboardType: TextInputType.number,
                    validator: (value) => value == null || value.trim().isEmpty ? "litters are required" : null,
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    controller: _pricePerLiterController,
                    label: "Price per Liter",
                    hint: "Enter price per liter",
                    keyboardType: TextInputType.number,
                    validator: (value) => value == null || value.trim().isEmpty ? "Price per litter is required" : null,
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    read: true,
                    controller: _costController,
                    label: "Total Cost",
                    hint: "Enter total cost",
                    keyboardType: TextInputType.number,
                  ),

                  SizedBox(height: 10.h),
                CustomDatePicker(
                  controller: _dateController,
                  label: "Date",
                  hint: "Enter date (e.g. 01/07/2025)",
                  validator: (value) => value == null || value.trim().isEmpty ? "Date is required" : null,
                ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    controller: _odometerController,
                    label: "Odometer Reading (Optional)",
                    hint: "Enter odometer (km)",
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 30.h),
                  Custom_Button(
                    title: "Save Entry",
                    font: 14,
                    wid: double.infinity,
                    BoxColor: theme.primaryColor,
                    BorderColor: theme.primaryColor,
                    TextColor: theme.scaffoldBackgroundColor,
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        final vehicleController = Get.find<VehicleController>();
                        if (vehicleController.defaultVehicle == null) {
                          Get.snackbar(
                            'No Vehicle Found',
                            'Please add a vehicle before saving fuel entry',
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.redAccent,
                            colorText: Colors.white,
                          );

                          // Navigate to Add Vehicle screen
                          Future.delayed(const Duration(milliseconds: 500), () {
                            Get.to(()=>const AddVehicleScreen());
                          });
                          return;
                        }
                        if (_formKey.currentState!.validate()) {
                          final fuel = FuelModel(
                            fuelType: _selectedFuelType ?? 'Petrol',
                            liters: double.tryParse(_litersController.text.trim()) ?? 0.0,
                            pricePerLiter: double.tryParse(_pricePerLiterController.text.trim()) ?? 0.0,
                            totalCost: double.tryParse(_costController.text.trim()) ?? 0.0,
                            odometer: double.tryParse(_odometerController.text.trim()) ?? 0.0,
                            date: _dateController.text.trim().isNotEmpty
                                ? _dateController.text.trim()
                                : DateTime.now().toString(),
                            vehicleName: Get.find<VehicleController>().defaultVehicle != null
                                ? '${Get.find<VehicleController>().defaultVehicle!.brand} ${Get.find<VehicleController>().defaultVehicle!.model}'
                                : 'Unknown',
                          );

                          Get.find<FuelController>().addFuel(fuel);
                          Get.back();
                          Get.snackbar('Success', 'Fuel entry saved');
                        }
                      }
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}