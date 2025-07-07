import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 3)
class UserModel extends HiveObject {
  @HiveField(0)
  String fullName;

  @HiveField(1)
  String email;

  @HiveField(2)
  String phone;

  @HiveField(3)
  String age;

  @HiveField(4)
  String gender;

  @HiveField(5)
  String? imagePath; // optional image path

  UserModel({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.age,
    required this.gender,
    this.imagePath,
  });
}
