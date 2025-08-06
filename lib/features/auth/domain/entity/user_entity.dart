class UserEntity {
  final String uid;
  final int mobile;
  final String? name;
  final String? profilePic;
  final bool isOnline;
  UserEntity({
    required this.uid,
    required this.mobile,
    this.name,
    this.isOnline = false,
    this.profilePic,
  });
}
