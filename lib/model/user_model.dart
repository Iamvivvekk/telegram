// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String uid;
  final int mobile;
  final String? name;
  final String? profilePic;
  UserModel({
    required this.uid,
    required this.mobile,
    this.name,
    this.profilePic,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['_id'] as String,
      mobile: json['mobile'] as int,
      name: json['fullName'] as String?,
      profilePic: json['photoUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'mobile': mobile,
      'profilePic': profilePic,
    };
  }
}
