import 'package:telegram/core/typedef.dart';
import 'package:telegram/features/auth/domain/entity/user_entity.dart';
import 'package:telegram/features/auth/domain/repository/auth_repository.dart';

class LoginUsecase {
  final AuthRepository authRepository;

  LoginUsecase({required this.authRepository});
  
  FutureEither<String> sendOtp(String phoneNumber) {
    return authRepository.sendOtp(phoneNumber);
  }

  FutureEither<UserEntity> verifyOtp(String verificationId, String smsCode) {
    return authRepository.verifyOtp(verificationId, smsCode);
  }
}
