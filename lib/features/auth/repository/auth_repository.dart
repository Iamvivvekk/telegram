import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:telegram/core/common/providers/firebase_providers.dart';
import 'package:telegram/core/services/dio_services.dart';
import 'package:telegram/core/typedef.dart';
import 'package:telegram/core/utils/failure.dart';

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

  bool get user => _auth.currentUser!.uid.isEmpty;

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

  FutureEither<UserCredential> verifyOtp(
    String verificationId,
    String smsCode,
  ) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      final userCredential = await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        return right(userCredential);
      } else {
        throw "OTP verification failed";
      }
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.message!));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // FutureEither<UserModel> getUser() {
  //   _dio.get("");
  // }
}
