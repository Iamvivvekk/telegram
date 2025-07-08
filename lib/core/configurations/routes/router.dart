import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/configurations/routes/route_names.dart';
import 'package:telegram/features/auth/screens/auth_screen.dart';
import 'package:telegram/features/auth/screens/otp_screen.dart';
import 'package:telegram/features/home/screen/home_screen.dart';
import 'package:telegram/features/onboarding/screen/onboarding_screen.dart';
import 'package:telegram/features/user_information/screen/user_information_screen.dart';

final routerProvider = Provider<Routes>((ref) {
  return Routes(ref);
});

class Routes {
  final Ref ref;
  Routes(this.ref);
  GoRouter router() => GoRouter(
    // redirect: (context, state) {
    //   final isLoggedIn = ref
    //       .watch(authControllerProvider.notifier)
    //       .isUserLoggedIn();

    //   if (isLoggedIn) {
    //     return "/home";
    //   } else {
    //     return "/";
    //   }
    // },
    onException: (context, state, router) {
      const MaterialPage(
        child: Scaffold(body: Center(child: Text("Page not found"))),
      );
    },
    routes: [
      GoRoute(
        path: "/",
        name: RouteNames.onBoarding,
        builder: (context, state) => OnboadingScreen(),
      ),
      GoRoute(
        path: "/auth",
        name: RouteNames.auth,
        builder: (context, state) => AuthScreen(),
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
        builder: (context, state) => UserInfoScreen(),
      ),
      GoRoute(
        path: "/home",
        name: RouteNames.home,
        builder: (context, state) => HomeScreen(),
      ),
    ],
  );
}
