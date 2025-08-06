part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class SendingOtpState extends AuthState {}

final class VerifyingOtpState extends AuthState {}

final class AuthAfterOtpSentState extends AuthState {
  final String verificationId;

  AuthAfterOtpSentState({required this.verificationId});
}

final class Authenticated extends AuthState {
  final UserEntity user;

  Authenticated({required this.user});
}

final class AuthFailure extends AuthState {
  AuthFailure({required this.message});
  final String message;
}
