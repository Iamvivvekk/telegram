// import 'dart:developer';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:telegram/core/configurations/routes/route_names.dart';
// import 'package:telegram/core/constants/shared_preferences_keys.dart';
// import 'package:telegram/core/utils/show_snackbar.dart';
// import 'package:telegram/features/auth/repository/auth_repository.dart';
// import 'package:telegram/model/user_model.dart';
// import 'package:telegram/providers/user_data_provider.dart';

// final authControllerProvider = StateNotifierProvider<AuthController, bool>((
//   ref,
// ) {
//   return AuthController(ref.read(authRepositoryProvider), ref);
// });

// class AuthController extends StateNotifier<bool> {
//   final AuthRepository _authRepository;
//   final Ref _ref;
//   AuthController(AuthRepository authRepository, Ref ref)
//     : _authRepository = authRepository,
//       _ref = ref,
//       super(false);


//   Future<void> signInWithPhone(BuildContext context, String phoneNumber) async {
//     state = true;
//     final result = await _authRepository.sendOtp(phoneNumber);

//     result.fold(
//       (l) {
//         state = false;
//         showSnackbar(context, l.message);
//       },
//       (verificationId) {
//         state = false;
//         context.pushNamed(
//           RouteNames.otp,
//           pathParameters: {"vid": verificationId},
//         );
//       },
//     );
//   }

//   void verifyOtp(
//     BuildContext context,
//     String verificationId,
//     String smsCode,
//   ) async {
//     state = true;
//     final result = await _authRepository.verifyOtp(verificationId, smsCode);
//     final prefs = await SharedPreferences.getInstance();

//     result.fold(
//       (error) {
//         state = false;
//         showSnackbar(context, error.message);
//         log(error.message);
//       },
//       (user) {
//         state = false;
//         _ref.read(userDataProvider.notifier).update((oldUser) => user);
//         prefs.setString(SharedPreferencesKeys.uid, user.uid);
//         showSnackbar(context, "OTP verified");
//         log(user.name.toString());
//         if (user.name == null || user.name!.isEmpty) {
//           context.pushNamed(RouteNames.userInfo);
//         } else {
//           context.pushNamed(RouteNames.home);
//         }
//       },
//     );
//   }

//   Future<void> signOut(BuildContext context) async {
//     final result = await _authRepository.signOut();
//     result.fold(
//       (error) {
//         showSnackbar(context, error.message);
//       },
//       (success) {
//         context.goNamed(RouteNames.auth);
//       },
//     );
//   }

//   Stream<User?> get user => _authRepository.user;

//   Future<UserModel?> getUser(BuildContext context) async {
//     final result = await _authRepository.getUser();
//     final prefs = await SharedPreferences.getInstance();
//     return result.fold(
//       (error) {
//         if (error.message.toLowerCase() == "unauthenticated") {
//           return null;
//         }
//         showSnackbar(context, error.message);
//         return null;
//       },
//       (newUser) {
//         prefs.setString(SharedPreferencesKeys.uid, newUser.uid);
//         _ref.read(userDataProvider.notifier).update((user) => newUser);
//         return newUser;
//       },
//     );
//   }
// }
