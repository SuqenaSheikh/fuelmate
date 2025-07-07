import 'package:fuelmate/model/fuel_entry.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';


// class FuelController extends GetxController {
//   final fuelBox = Hive.box<FuelModel>('fuelBox');
//   var fuelList = <FuelModel>[].obs;
//
//   @override
//   void onInit() {
//     fuelList.value = fuelBox.values.toList();
//     super.onInit();
//   }
//
//   void addFuel(FuelModel fuel) {
//     fuelBox.add(fuel);
//     fuelList.value = fuelBox.values.toList();
//   }
// }
class FuelController extends GetxController {
  final fuelList = <FuelModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFuelHistory();
  }

  void loadFuelHistory() {
    final box = Hive.box<FuelModel>('fuelBox');
    fuelList.assignAll(box.values.toList());
  }

  void addFuel(FuelModel fuel) {
    final box = Hive.box<FuelModel>('fuelBox');
    box.add(fuel);
    loadFuelHistory();
  }
}
