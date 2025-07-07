// controllers/bottom_bar_controller.dart
import 'package:get/get.dart';

class BottomBarController extends GetxController {
  var selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
