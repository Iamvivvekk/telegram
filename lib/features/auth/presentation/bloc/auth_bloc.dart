import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:telegram/features/auth/domain/entity/user_entity.dart';
import 'package:telegram/features/auth/domain/usecase/get_user_usecase.dart';
import 'package:telegram/features/auth/domain/usecase/login_usecase.dart';
import 'package:telegram/features/auth/domain/usecase/logout_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetUserUsecase getUserUsecase;
  final LoginUsecase loginUsecase;
  final LogoutUsecase logoutUsecase;
  AuthBloc({
    required this.getUserUsecase,
    required this.loginUsecase,
    required this.logoutUsecase,
  }) : super(AuthInitial()) {
    /// To get user
    on<AuthInitialEvent>(_onAuthInitialEvent);

    /// To Send OTP
    on<SendOtpEvent>(_onSendOtpEvent);

    /// To Verify OTP
    on<VerifyOtpEvent>(_onVerifyOtpEvent);

    /// To logout
    on<LogoutEvent>(_onLogoutEvent);
  }
  Future<void> _onAuthInitialEvent(AuthInitialEvent event, Emitter emit) async {
    emit(AuthInitial());
    final result = await getUserUsecase.getUser();
    result.fold(
      (error) {
        emit(AuthFailure(message: error.message));
      },
      (user) async {
        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setString(SharedPreferencesKeys.uid, user.uid);
        // user.name == null
        //     ? await prefs.setBool(SharedPreferencesKeys.isNewUser, true)
        //     : await prefs.setBool(SharedPreferencesKeys.isNewUser, false);

        emit(Authenticated(user: user));
      },
    );
  }

  Future<void> _onSendOtpEvent(SendOtpEvent event, Emitter emit) async {
    emit(SendingOtpState());
    final result = await loginUsecase.sendOtp(event.phoneNumber);

    result.fold(
      (error) {
        emit(AuthFailure(message: error.message));
      },
      (verificationId) {
        emit(AuthAfterOtpSentState(verificationId: verificationId));
      },
    );
  }

  Future<void> _onVerifyOtpEvent(VerifyOtpEvent event, Emitter emit) async {
    emit(VerifyingOtpState());
    final result = await loginUsecase.verifyOtp(
      event.verificationId,
      event.smsCode,
    );

    result.fold(
      (error) {
        emit(AuthFailure(message: error.message));
      },
      (user) async {
        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setString(SharedPreferencesKeys.uid, user.uid);
        if (user.name == null) {
          // await prefs.setBool(SharedPreferencesKeys.isNewUser, true);
        }
        emit(Authenticated(user: user));
      },
    );
  }

  Future<void> _onLogoutEvent(AuthEvent event, Emitter emit) async {}
}
