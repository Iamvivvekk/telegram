class UserModel {
  final String name;
  final String profilePic;
  final String uid;
  final bool isOnline;
  UserModel({
    required this.name,
    required this.profilePic,
    required this.uid,
    this.isOnline = false,
  });

  UserModel copyWith({
    String? name,
    String? profilePic,
    String? uid,
    bool? isOnline,
  }) {
    return UserModel(
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      uid: uid ?? this.uid,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'profilePic': profilePic,
      'uid': uid,
      'isOnline': isOnline,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      profilePic: map['profilePic'] as String,
      uid: map['uid'] as String,
      isOnline: map['isOnline'] as bool,
    );
  }

  @override
  String toString() {
    return 'UserModel(name: $name, profilePic: $profilePic, uid: $uid, isOnline: $isOnline)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.profilePic == profilePic &&
        other.uid == uid &&
        other.isOnline == isOnline;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        profilePic.hashCode ^
        uid.hashCode ^
        isOnline.hashCode;
  }
}
