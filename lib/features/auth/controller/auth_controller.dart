import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/configurations/routes/route_names.dart';
import 'package:telegram/core/utils/show_snackbar.dart';
import 'package:telegram/features/auth/repository/auth_repository.dart';
import 'package:telegram/providers/user_data_provider.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>((
  ref,
) {
  return AuthController(ref.read(authRepositoryProvider), ref);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController(AuthRepository authRepository, Ref ref)
    : _authRepository = authRepository,
      _ref = ref,
      super(false);

  void setFalse() {
    state = false;
  }

  Future<void> signInWithPhone(BuildContext context, String phoneNumber) async {
    state = true;
    final result = await _authRepository.sendOtp(phoneNumber);

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
    state = true;
    final result = await _authRepository.verifyOtp(verificationId, smsCode);

    result.fold(
      (error) {
        state = false;
        showSnackbar(context, error.message);
        log(error.message);
      },
      (user) {
        state = false;
        _ref.read(userDataProvider.notifier).update((oldUser) => user);
        showSnackbar(context, "OTP verified");
        print(user.name);
        if (user.name == null || user.name!.isEmpty) {
          context.pushNamed(RouteNames.userInfo);
        } else {
          context.pushNamed(RouteNames.home);
        }
      },
    );
  }

  Stream<User?> get user => _authRepository.user;

  Future<void> createOrGetUser() async {
    // final result = await _authRepository.verifyOtp();
  }
}
