import 'package:telegram/core/typedef.dart';
import 'package:telegram/features/auth/domain/entity/user_entity.dart';

abstract class AuthRepository {
  FutureEither<String> sendOtp(String phoneNumber);

  FutureEither<UserEntity> verifyOtp(String verificationId, String smsCode);

  FutureEither<UserEntity> getUser();

  FutureEither<bool> logout();
}
