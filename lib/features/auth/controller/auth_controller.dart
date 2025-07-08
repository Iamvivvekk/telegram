import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telegram/core/configurations/routes/route_names.dart';
import 'package:telegram/core/constants/shared_preferences_keys.dart';
import 'package:telegram/core/utils/show_snackbar.dart';
import 'package:telegram/features/auth/repository/auth_repository.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>((
  ref,
) {
  return AuthController(ref.read(authRepositoryProvider));
});

class AuthController extends StateNotifier<bool> {
  AuthRepository authRepository;
  AuthController(this.authRepository) : super(false);

  void setFalse() {
    state = false;
  }

  Future<void> signInWithPhone(BuildContext context, String phoneNumber) async {
    state = true;
    final result = await authRepository.sendOtp(phoneNumber);

    result.fold(
      (l) {
        state = false;
        showSnackbar(context, l.message);
      },
      (verificationId) {
        state = false;
        context.pushNamed(
          RouteNames.otp,
          pathParameters: {"vid": verificationId},
        );
      },
    );
  }

  void verifyOtp(
    BuildContext context,
    String verificationId,
    String smsCode,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    state = true;
    final result = await authRepository.verifyOtp(verificationId, smsCode);
    state = false;

    result.fold(
      (error) {
        showSnackbar(context, error.message);
        log(error.message);
      },
      (userCredential) {
        showSnackbar(context, "OTP verified");
        if (userCredential.additionalUserInfo != null) {
          preferences.setBool(
            SharedPreferencesKeys.isNewUser,
            userCredential.additionalUserInfo!.isNewUser,
          );
          preferences.setString(
            SharedPreferencesKeys.uid,
            userCredential.user?.uid ?? "",
          );
        }
        userCredential.additionalUserInfo!.isNewUser
            ? context.goNamed(RouteNames.userInfo)
            : context.goNamed(RouteNames.home);
      },
    );
  }

  // bool isUserLoggedIn() {
  //   return true;
  //   return false;
  // }
}
