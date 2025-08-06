part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthInitialEvent extends AuthEvent {}

final class SendOtpEvent extends AuthEvent {
  SendOtpEvent({required this.phoneNumber});

  final String phoneNumber;
}

final class VerifyOtpEvent extends AuthEvent {
  VerifyOtpEvent({required this.verificationId, required this.smsCode});

  final String verificationId;
  final String smsCode;
}

final class LogoutEvent extends AuthEvent {}
