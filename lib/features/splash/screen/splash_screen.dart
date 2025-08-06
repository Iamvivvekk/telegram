import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/configurations/routes/route_names.dart';
import 'package:telegram/core/constants/image_constants.dart';
import 'package:telegram/core/utils/reusable_text.dart';
import 'package:telegram/features/auth/presentation/bloc/auth_bloc.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(seconds: 2), () {

    // });
    getUser();
  }

  void getUser() {
    BlocProvider.of<AuthBloc>(context).add(AuthInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    print("splash screen ");
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          print("error is ${state.message}");
        }
        print("splash $state");
        if (state is Authenticated) {
          context.goNamed(RouteNames.home);
        } else {
          context.goNamed(RouteNames.onBoarding);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(ImageConstants.appLogo),
                ),
                const SizedBox(height: 18),
                const ReusableText(
                  "Telegram",
                  fontsize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
        );
      },
      // child: Scaffold(
      //   backgroundColor: Theme.of(context).primaryColor,
      //   body: Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         Container(
      //           height: 160,
      //           width: 160,
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(80),
      //           ),
      //           clipBehavior: Clip.antiAlias,
      //           child: Image.asset(ImageConstants.appLogo),
      //         ),
      //         const SizedBox(height: 18),
      //         const ReusableText(
      //           "Telegram",
      //           fontsize: 24,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
