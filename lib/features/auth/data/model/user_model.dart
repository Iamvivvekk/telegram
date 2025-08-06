import 'package:telegram/features/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.uid,
    required super.mobile,
    required super.name,
    required super.profilePic,
    required super.isOnline,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["_id"],
      mobile: json["mobile"],
      name: json["fullName"],
      profilePic: json["photoUrl"],
      isOnline: true,
    );
  }
}
