import 'package:hive/hive.dart';
part 'trip_model.g.dart';

@HiveType(typeId: 6) // Use a new, unused typeId
class NewTripModel extends HiveObject {
  @HiveField(0)
  String tripName;

  @HiveField(1)
  String tripType;

  @HiveField(2)
  double distance; // in kilometers

  @HiveField(3)
  String date;

  @HiveField(4)
  String? notes;

  @HiveField(5)
  double mileage; // in km/l

  NewTripModel({
    required this.tripName,
    required this.tripType,
    required this.distance,
    required this.date,
    this.notes,
    required this.mileage,
  });
}
