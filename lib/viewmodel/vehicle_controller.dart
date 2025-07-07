import 'package:fuelmate/model/vehicle_model.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class VehicleController extends GetxController {
  final vehicleBox = Hive.box<VehicleModel>('vehiclesBox');

  /// Observable selected vehicle ID
  final RxString defaultVehicleId = ''.obs;

  /// Returns all vehicles
  List<VehicleModel> get allVehicles => vehicleBox.values.toList();

  /// Get default vehicle
  VehicleModel? get defaultVehicle =>
      allVehicles.firstWhereOrNull((v) => v.isDefault);

  @override
  void onInit() {
    super.onInit();
    defaultVehicleId.value = defaultVehicle?.id ?? '';
    vehicleBox.listenable().addListener(() {
      defaultVehicleId.value = defaultVehicle?.id ?? '';
      update();
    });
  }

  /// Add vehicle to Hive
  void addVehicle({
    required String brand,
    required String model,
    required String imagePath,
    String? licensePlate,
    String? fuelType,
    String? transmission,
    String? vehicleType,
    String? year,
  }) {
    final isFirst = allVehicles.isEmpty;

    final newVehicle = VehicleModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      brand: brand,
      model: model,
      imagePath: imagePath,
      licensePlate: licensePlate ?? '',
      fuelType: fuelType ?? '',
      transmission: transmission ?? '',
      vehicleType: vehicleType ?? '',
      isDefault: isFirst,
      year: year ?? '',
    );

    vehicleBox.put(newVehicle.id, newVehicle);
    update();

    // Update selected vehicle ID if it's first
    if (isFirst) {
      defaultVehicleId.value = newVehicle.id;
    }
  }

  /// Set default vehicle
  void setDefaultVehicle(String id) {
    for (var vehicle in allVehicles) {
      vehicle.isDefault = vehicle.id == id;
      vehicle.save();
    }

    update(); // For GetBuilder
    defaultVehicleId.value = id; // For Obx
  }

  /// Delete a vehicle
  void deleteVehicle(String id) {
    vehicleBox.delete(id);
    update();

    // Recalculate default
    final newDefault = defaultVehicle;
    defaultVehicleId.value = newDefault?.id ?? '';
  }
}
