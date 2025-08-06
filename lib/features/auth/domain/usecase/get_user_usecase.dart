import 'package:telegram/core/typedef.dart';
import 'package:telegram/features/auth/domain/entity/user_entity.dart';
import 'package:telegram/features/auth/domain/repository/auth_repository.dart';

class GetUserUsecase {
  final AuthRepository authRepository;

  GetUserUsecase({required this.authRepository});

  FutureEither<UserEntity> getUser() {
    return authRepository.getUser();
  }
}
