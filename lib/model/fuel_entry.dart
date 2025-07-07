import 'package:hive/hive.dart';

part 'fuel_entry.g.dart';

@HiveType(typeId: 0)
class FuelModel extends HiveObject {
  @HiveField(0)
  final String fuelType;

  @HiveField(1)
  final double liters;

  @HiveField(2)
  final double pricePerLiter;

  @HiveField(3)
  final double totalCost;

  @HiveField(4)
  final double odometer;

  @HiveField(5)
  final String date;

  @HiveField(6)
  final String vehicleName;

  FuelModel({
    required this.fuelType,
    required this.liters,
    required this.pricePerLiter,
    required this.totalCost,
    required this.odometer,
    required this.date,
    required this.vehicleName,
  });
}
