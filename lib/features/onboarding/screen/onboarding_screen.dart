import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/common/widgets/custom_button.dart';
import 'package:telegram/core/common/widgets/height.dart';
import 'package:telegram/core/configurations/routes/route_names.dart';
import 'package:telegram/core/constants/image_constants.dart';
import 'package:telegram/core/utils/text_styles.dart';

class OnboadingScreen extends StatelessWidget {
  const OnboadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              Text("Telegram", style: normalText(fontsize: 24)),
              const HeightSpacer(),
              Text(
                "The World's fastest messaging app\n It is free and secure",
                style: normalText(),
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
