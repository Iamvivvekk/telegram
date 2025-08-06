import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:telegram/core/Errors/error_handler.dart';
import 'package:telegram/core/constants/api_constants.dart';
import 'package:telegram/core/services/dio_services.dart';
import 'package:telegram/core/typedef.dart';
import 'package:telegram/core/utils/failure.dart';
import 'package:telegram/features/auth/data/model/user_model.dart';

class AuthRemoteDatasource {
  final DioServices dio;
  final FirebaseAuth auth;

  AuthRemoteDatasource({required this.dio, required this.auth});

  FutureEither<String> sendOtp(String phoneNumber) async {
    final completer = Completer<Either<Failure, String>>();

    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (!completer.isCompleted) {
            completer.complete(left(Failure(e.code)));
          }
        },
        codeSent: (String verificationId, int? resendToken) async {
          if (!completer.isCompleted) {
            completer.complete(right(verificationId));
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );

      return completer.future;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<UserModel> verifyOtp(
    String verificationId,
    String smsCode,
  ) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      final userCredential = await auth.signInWithCredential(credential);

      final response = await dio.dio.post(
        ApiConstants.signin,
        data: jsonEncode({
          "uid": userCredential.user!.uid,
          "mobile": userCredential.user!.phoneNumber,
        }),
      );

      if (response.statusCode == 200) {
        final user = UserModel.fromJson(response.data['user']);
        return right(user);
      }
      if (response.statusCode == 201) {
        final user = UserModel.fromJson(response.data['user']);
        return right(user);
      }
      throw response.data['message'];
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.message!));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<UserModel> getUser() async {
    try {
      final uid = auth.currentUser?.uid;
      if (uid == null || uid.isEmpty) {
        return left(Failure("Unauthenticated"));
      }
      final response = await dio.dio.get(
        ApiConstants.getUser,
        options: Options(headers: {"authorization": auth.currentUser!.uid}),
      );
      if (response.statusCode == 200) {
        final user = UserModel.fromJson(response.data['user']);
        return right(user);
      }
      throw response.data['message'];
    } catch (e) {
      return left(Failure(ErrorHandler.call(e)));
    }
  }

  FutureEither<bool> logOut() async {
    try {
      await auth.signOut();
      return right(true);
    } catch (e) {
      return left(Failure(ErrorHandler.call(e)));
    }
  }
}
