import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:telegram/core/configurations/routes/router.dart';
import 'package:telegram/core/configurations/theme/theme.dart';
import 'package:telegram/core/services/socket_services.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(socketProvider);
    return MaterialApp.router(
      title: "Telegram",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme(context),
      routerConfig: ref.read(routerProvider).router(),
    );
  }
}
