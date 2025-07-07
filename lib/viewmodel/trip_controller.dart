import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../model/trip_model.dart';

class TripController extends GetxController {
  final Box<NewTripModel> _tripBox = Hive.box<NewTripModel>('tripBox');
  var trips = <NewTripModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTrips();
  }

  void loadTrips() {
    trips.value = _tripBox.values.toList();
  }

  void addTrip(NewTripModel trip) {
    _tripBox.add(trip);
    loadTrips();
  }
}
