import 'package:hive/hive.dart';

part 'vehicle_model.g.dart';

@HiveType(typeId: 2)
class VehicleModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String brand;

  @HiveField(2)
  String model;

  @HiveField(3)
  String year;

  @HiveField(4)
  String licensePlate;

  @HiveField(5)
  String fuelType;

  @HiveField(6)
  String transmission;

  @HiveField(7)
  String vehicleType;

  @HiveField(8)
  String imagePath;

  @HiveField(9)
  bool isDefault;

  VehicleModel({
    required this.id,
    required this.brand,
    required this.model,
    required this.year,
    required this.licensePlate,
    required this.fuelType,
    required this.transmission,
    required this.vehicleType,
    required this.imagePath,
    this.isDefault = false,
  });
}
