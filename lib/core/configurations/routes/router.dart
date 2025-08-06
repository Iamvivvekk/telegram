import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/configurations/routes/route_names.dart';
import 'package:telegram/core/utils/reusable_text.dart';
import 'package:telegram/features/auth/presentation/screens/auth_screen.dart';
import 'package:telegram/features/auth/presentation/screens/otp_screen.dart';
import 'package:telegram/features/chat/screen/chat_screen.dart';
import 'package:telegram/features/home/screen/home_screen.dart';
import 'package:telegram/features/onboarding/screen/onboarding_screen.dart';
import 'package:telegram/features/search/presentation/screen/search_screen.dart';
import 'package:telegram/features/search%20copy/presentation/screen/setting_screen.dart';
import 'package:telegram/features/splash/screen/splash_screen.dart';
import 'package:telegram/features/user_information/screen/user_information_screen.dart';

final routerProvider = Provider<Routes>((ref) {
  return Routes();
});

class Routes {
  static final Routes _instance = Routes._internal();

  factory Routes() => _instance;

  Routes._internal();

  GoRouter router() => GoRouter(
    // initialLocation: "/search",
    onException: (context, state, router) {
      const MaterialPage(
        child: Scaffold(body: Center(child: ReusableText("Page not found"))),
      );
    },
    routes: [
      GoRoute(
        path: "/",
        name: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: "/onboarding",
        name: RouteNames.onBoarding,
        builder: (context, state) => const OnboadingScreen(),
      ),
      GoRoute(
        path: "/auth",
        name: RouteNames.auth,
        builder: (context, state) => const AuthScreen(),
        routes: [
          GoRoute(
            path: '/verify-otp/:vid',
            name: RouteNames.otp,
            builder: (context, state) =>
                OtpScreen(verificationId: state.pathParameters['vid']!),
          ),
        ],
      ),
      GoRoute(
        path: "/auth/user-info",
        name: RouteNames.userInfo,
        builder: (context, state) => const UserInfoScreen(),
      ),
      GoRoute(
        path: "/home",
        name: RouteNames.home,
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: "/chat",
            name: RouteNames.chat,
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>;
              return ChatScreen(conversation: extra["conversation"]);
            },
          ),
        ],
      ),
      GoRoute(
        path: "/search",
        name: RouteNames.search,
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: "/settings",
        name: RouteNames.settings,
        builder: (context, state) => const SettingScreen(),
      ),
    ],
  );
}
