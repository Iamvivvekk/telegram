import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:telegram/core/common/providers/firebase_providers.dart';
import 'package:telegram/core/constants/api_constants.dart';
import 'package:telegram/core/services/dio_services.dart';
import 'package:telegram/core/typedef.dart';
import 'package:telegram/core/utils/failure.dart';
import 'package:telegram/model/user_model.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final firebasAuth = ref.read(firebaseAuthProvider);
  final dio = ref.read(dioServiceProvider);

  return AuthRepository(auth: firebasAuth, dio: dio);
});

class AuthRepository {
  final FirebaseAuth _auth;
  final Dio _dio;

  AuthRepository({required FirebaseAuth auth, required Dio dio})
    : _dio = dio,
      _auth = auth;

  Stream<User?> get user => _auth.authStateChanges();

  FutureEither<String> sendOtp(String phoneNumber) async {
    final completer = Completer<Either<Failure, String>>();

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
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
      final userCredential = await _auth.signInWithCredential(credential);

      final response = await _dio.post(
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

  Future createUser() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;
    final response = await _dio.get(ApiConstants.signin);
  }
}
