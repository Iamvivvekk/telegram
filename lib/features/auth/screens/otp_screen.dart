import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:telegram/core/common/widgets/custom_button.dart';
import 'package:telegram/core/common/widgets/height.dart';
import 'package:telegram/core/configurations/colors.dart';
import 'package:telegram/core/utils/loader.dart';
import 'package:telegram/core/utils/size.dart';
import 'package:telegram/core/utils/text_styles.dart';
import 'package:telegram/features/auth/controller/auth_controller.dart';

class OtpScreen extends ConsumerStatefulWidget {
  const OtpScreen({super.key, required this.verificationId});
  final String verificationId;

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.verificationId);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 3),
              const Icon(Icons.security, color: AppColor.primary, size: 80),
              const HeightSpacer(height: 30),
              Text(
                "Check your Telegram messages",
                style: normalText(fontsize: 18),
              ),
              const HeightSpacer(),
              Text(
                "We've sent the code to your phone number",
                style: greyText(fontsize: 14),
              ),
              const Spacer(flex: 1),
              Pinput(
                controller: _otpController,
                length: 6,
                followingPinTheme: _followingPinTheme(),
                defaultPinTheme: _defaultPinTheme(),
              ),
              const Spacer(flex: 6),
              SizedBox(
                width: ScreenUtil.getSize(context).width * 0.75,
                child: CustomButton(
                  onTap: () {
                    ref
                        .read(authControllerProvider.notifier)
                        .verifyOtp(
                          context,
                          widget.verificationId,
                          _otpController.text.trim(),
                        );
                  },
                  text: "Go to home",
                  child: ref.watch(authControllerProvider)
                      ? const Loader()
                      : null,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  PinTheme _defaultPinTheme() {
    return PinTheme(
      textStyle: normalText(),
      height: 46,
      width: 40,
      decoration: BoxDecoration(
        color: AppColor.transparent,
        border: Border.all(color: AppColor.otpBorder, width: 2),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }

  PinTheme _followingPinTheme() {
    return PinTheme(
      textStyle: normalText(),
      height: 46,
      width: 40,
      decoration: BoxDecoration(
        color: AppColor.transparent,
        border: Border.all(color: AppColor.greyText),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
