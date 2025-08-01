import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/common/widgets/custom_button.dart';
import 'package:telegram/core/common/widgets/height.dart';
import 'package:telegram/core/configurations/routes/route_names.dart';
import 'package:telegram/core/constants/image_constants.dart';
import 'package:telegram/core/utils/reusable_text.dart';

class OnboadingScreen extends ConsumerWidget {
  const OnboadingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                height: 120,
                width: 120,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(ImageConstants.appLogo),
              ),
              const SizedBox(height: 12),
              const ReusableText("Telegram", fontsize: 24),
              const HeightSpacer(),
              const Text(
                "The World's fastest messaging app\n It is free and secure",

                textAlign: TextAlign.center,
              ),
              const Spacer(),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.75,
                child: CustomButton(
                  onTap: () {
                    context.pushNamed(RouteNames.auth);
                  },
                  text: "Start Messaging",
                ),
              ),
              const HeightSpacer(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}
