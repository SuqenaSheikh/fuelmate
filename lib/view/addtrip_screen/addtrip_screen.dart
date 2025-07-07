import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuelmate/model/trip_model.dart';
import 'package:fuelmate/view/ads/intrestitial_ad.dart';
import 'package:fuelmate/view/global_widgets/custom_Appbar.dart';
import 'package:fuelmate/view/global_widgets/custom_button.dart';
import 'package:fuelmate/view/global_widgets/custom_date_widget.dart';
import 'package:fuelmate/view/global_widgets/custom_dropdown.dart';
import 'package:fuelmate/view/global_widgets/custom_textfield.dart';
import 'package:fuelmate/view/tripsummary_screen/trip_summary.dart';
import 'package:fuelmate/view/vehicle_screens/addvehicle.dart';
import 'package:fuelmate/viewmodel/trip_controller.dart';
import 'package:fuelmate/viewmodel/vehicle_controller.dart';
import 'package:get/get.dart';

class AddTripScreen extends StatefulWidget {
  const AddTripScreen({super.key});

  @override
  State<AddTripScreen> createState() => _AddTripScreenState();
}

class _AddTripScreenState extends State<AddTripScreen> {
  final _formKey = GlobalKey<FormState>();

  final _tripNameController = TextEditingController();
  final _startOdometerController = TextEditingController();
  final _endOdometerController = TextEditingController();
  final _distanceController = TextEditingController();
  final _dateController = TextEditingController();
  final _notesController = TextEditingController();
  final _mileageController = TextEditingController();

  String? _selectedTripType;
  final List<String> tripTypes = ['Business', 'Personal'];

  @override
  void dispose() {
    _tripNameController.dispose();
    _startOdometerController.dispose();
    _endOdometerController.dispose();
    _distanceController.dispose();
    _dateController.dispose();
    _notesController.dispose();
    super.dispose();
  }
  TripController tripController = Get.find();

  void onTripAdded(NewTripModel trip) {
    tripController.addTrip(trip);

    // Show interstitial ad before navigating to summary
    AdHelper.loadInterstitialAd(
      onAdClosed: () {
        // Navigate to trip summary after ad is closed
        Get.off(() => TripSummaryScreen(trip: trip));
      },
    );
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
                  Custom_AppBar(title: 'Add New Trip'),
                  SizedBox(height:30.h),
                  CustomTextField(
                    controller: _tripNameController,
                    label: "Trip Destination",
                    hint: "e.g. Swat",
                    validator: (value) => value == null || value.trim().isEmpty ? "Trip Name is required" : null,
                  ),
                  SizedBox(height: 10.h),
                  CustomDropdown(
                    label: "Trip Type",
                    value: _selectedTripType,
                    items: tripTypes,
                    onChanged: (val) => setState(() => _selectedTripType = val),
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    controller: _startOdometerController,
                    label: "Add distance You need to travel",
                    hint: "Enter start reading (km)",
                    keyboardType: TextInputType.number,
                    validator: (value) => value == null || value.trim().isEmpty ? "Enter Distance in km" : null,

                  ),
                  CustomTextField(
                    controller: _mileageController,
                    label: "Mileage (km/l)",
                    hint: "e.g. 14.5",
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    validator: (value) => value == null || value.trim().isEmpty
                        ? "Enter mileage"
                        : null,
                  ),


                  SizedBox(height: 10.h),

                  CustomDatePicker(
                    controller: _dateController,
                    label: "Date",
                    hint: "Enter trip date (e.g. 01/07/2025)",
                    validator: (value) => value == null || value.trim().isEmpty ? "Date is required" : null,
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    controller: _notesController,
                    label: "Notes (Optional)",
                    hint: "Optional remarks...",
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 30.h),
                  Custom_Button(
                    title: "Save Trip",
                    font: 14,
                    wid: double.infinity,
                    BoxColor: theme.primaryColor,
                    BorderColor: theme.primaryColor,
                    TextColor: theme.scaffoldBackgroundColor,
                    onPressed: () {
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
                        final double distance = double.tryParse(_startOdometerController.text) ?? 0;
                        final double mileage = double.tryParse(_mileageController.text) ?? 0;
                        final trip = NewTripModel(
                          tripName: _tripNameController.text.trim(),
                          tripType: _selectedTripType ?? 'Personal',
                          distance: distance,
                          mileage: mileage,
                          date: _dateController.text,
                          notes: _notesController.text.isEmpty ? null : _notesController.text.trim(),
                        );

                        onTripAdded(trip);
                        Get.snackbar('Success', 'Trip saved successfully');
                      }
                    },
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
