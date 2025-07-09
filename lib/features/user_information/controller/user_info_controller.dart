import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/configurations/routes/route_names.dart';
import 'package:telegram/core/utils/show_snackbar.dart';
import 'package:telegram/features/user_information/repository/user_information_repository.dart';

final userInfoControllerProvider =
    StateNotifierProvider<UserInfoController, bool>((ref) {
      return UserInfoController(ref.read(userInfoRepositoryProvider));
    });

class UserInfoController extends StateNotifier<bool> {
  final UserInformationRepository _informationRepository;
  UserInfoController(UserInformationRepository informationRepository)
    : _informationRepository = informationRepository,
      super(false);

  Future<void> addAdditionalInfo(
    String fullName,
    File? profileFile,
    BuildContext context,
  ) async {
    state = true;

    final result = await _informationRepository.addUserInfo(
      fullName,
      profileFile,
    );

    result.fold(
      (error) {
        print(error.message);
        state = false;
        showSnackbar(context, error.message);
      },
      (user) {
        log(user.toString());
        state = false;
        context.pushNamed(RouteNames.home);
      },
    );
  }
}
