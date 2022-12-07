import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  final int id;
  final String email;
  final String first_name;
  final String last_name;
  final String avatar;

  UserModel({
    required this.id,
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.avatar,
  });

  // this auto generate make file user.g.dart
  factory UserModel.fromJson(Map<String, dynamic> data) =>
      _$UserModelFromJson(data);

  // this manual
  // factory UserModel.fromMap(Map<String, dynamic> data) {
  //   return UserModel(
  //     id: data["id"],
  //     email: data["email"],
  //     first_name: data["first_name"],
  //     last_name: data["last_name"],
  //     avatar: data["avatar"],
  //   );
  // }
}
