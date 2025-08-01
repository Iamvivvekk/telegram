import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/configurations/routes/route_names.dart';
import 'package:telegram/core/utils/show_snackbar.dart';
import 'package:telegram/features/user_information/repository/user_information_repository.dart';
import 'package:telegram/providers/user_data_provider.dart';

final userInfoControllerProvider =
    StateNotifierProvider<UserInfoController, bool>((ref) {
      return UserInfoController(ref.read(userInfoRepositoryProvider), ref);
    });

class UserInfoController extends StateNotifier<bool> {
  final UserInformationRepository _informationRepository;
  final Ref _ref;
  UserInfoController(UserInformationRepository informationRepository, Ref ref)
    : _ref = ref,
      _informationRepository = informationRepository,
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
        state = false;
        showSnackbar(context, error.message);
      },
      (user) {
        log(user.toString());
        state = false;
        _ref.read(userDataProvider.notifier).update((u) => user);
        context.goNamed(RouteNames.home);
      },
    );
  }
}
