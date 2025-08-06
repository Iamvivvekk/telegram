import 'package:telegram/core/typedef.dart';
import 'package:telegram/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:telegram/features/auth/data/model/user_model.dart';
import 'package:telegram/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl({required this.authRemoteDatasource});
  @override
  FutureEither<String> sendOtp(String phoneNumber) {
    return authRemoteDatasource.sendOtp(phoneNumber);
  }

  @override
  FutureEither<UserModel> verifyOtp(String verificationId, String smsCode) {
    return authRemoteDatasource.verifyOtp(verificationId, smsCode);
  }

  @override
  FutureEither<UserModel> getUser() {
    return authRemoteDatasource.getUser();
  }

  @override
  FutureEither<bool> logout() {
    return authRemoteDatasource.logOut();
  }
}
