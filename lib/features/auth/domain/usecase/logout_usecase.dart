import 'package:telegram/core/typedef.dart';
import 'package:telegram/features/auth/domain/repository/auth_repository.dart';

class LogoutUsecase {
  final AuthRepository authRepository;

  LogoutUsecase({required this.authRepository});

  FutureEither<bool> logout() {
    return authRepository.logout();
  }
}
