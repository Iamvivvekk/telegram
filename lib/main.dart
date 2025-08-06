import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:telegram/app.dart';
import 'package:telegram/core/services/dio_services.dart';
import 'package:telegram/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:telegram/features/auth/data/repository/auth_repository_impl.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final authRepositoryImpl = AuthRepositoryImpl(
    authRemoteDatasource: AuthRemoteDatasource(
      dio: DioServices(),
      auth: FirebaseAuth.instance,
    ),
  );
  runApp(MyApp(authRepositoryImpl: authRepositoryImpl));
}
