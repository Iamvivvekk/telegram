import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:telegram/core/constants/image_constants.dart';
import 'package:telegram/core/utils/reusable_text.dart';
import 'package:telegram/features/splash/controller/splash_controller.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() {
   final user =  ref.read(splashControllerProvider).getUser(context);
  //  if()
  }

  @override
  Widget build(BuildContext context) {
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
             fontsize: 24, fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
