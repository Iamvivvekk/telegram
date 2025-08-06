import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/configurations/routes/router.dart';
import 'package:telegram/core/configurations/theme/theme.dart';
import 'package:telegram/features/auth/data/repository/auth_repository_impl.dart';
import 'package:telegram/features/auth/domain/usecase/get_user_usecase.dart';
import 'package:telegram/features/auth/domain/usecase/login_usecase.dart';
import 'package:telegram/features/auth/domain/usecase/logout_usecase.dart';
import 'package:telegram/features/auth/presentation/bloc/auth_bloc.dart';

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepositoryImpl;

  const MyApp({super.key, required this.authRepositoryImpl});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            getUserUsecase: GetUserUsecase(authRepository: authRepositoryImpl),
            loginUsecase: LoginUsecase(authRepository: authRepositoryImpl),
            logoutUsecase: LogoutUsecase(authRepository: authRepositoryImpl),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: "Telegram",
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme(context),
        routerConfig: Routes().router(),
      ),
    );
  }
}
