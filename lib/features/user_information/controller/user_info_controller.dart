import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:telegram/features/auth/repository/auth_repository.dart';

final userInfoProvider =
    StateNotifierProvider<UserInfoDataNotifier, File?>((ref) {
  return UserInfoDataNotifier(ref.read(authRepositoryProvider), ref);
});

class UserInfoDataNotifier extends StateNotifier<File?> {
  final AuthRepository auth;
  final Ref ref;

  UserInfoDataNotifier(this.auth, this.ref) : super(null);

  void updateImage(File file) {
    state = file;
  }

  // void saveDetailsToFirebase(
  //   BuildContext context,
  //   String name,
  //   File? photo,
  // ) async {
  //   final result = await auth.saveUserDetailsToFirebase(
  //     name: name,
  //     photo: photo,
  //     ref: ref,
  //   );

  //   result.fold(
  //     (l) {
  //       showSnackbar(context, l.message);
  //     },
  //     (r) {
  //       context.goNamed(RouteNames.home);
  //     },
  //   );
  // }
}

class UserInfoData {
  final String name;
  final File? file;
  UserInfoData({
    required this.name,
    required this.file,
  });

  UserInfoData copyWith({
    String? name,
    File? file,
  }) {
    return UserInfoData(
      name: name ?? this.name,
      file: file ?? this.file,
    );
  }
}
