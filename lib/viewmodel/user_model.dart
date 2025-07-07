import 'package:fuelmate/model/user_model.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserController extends GetxController {
  final Box<UserModel> _userBox = Hive.box<UserModel>('userBox');

  UserModel? get user => _userBox.get('profile');

  void saveUser(UserModel userModel) {
    _userBox.put('profile', userModel);
    update();
  }
}
