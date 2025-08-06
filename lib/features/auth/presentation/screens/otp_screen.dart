import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:telegram/core/common/widgets/custom_button.dart';
import 'package:telegram/core/common/widgets/height.dart';
import 'package:telegram/core/configurations/colors.dart';
import 'package:telegram/core/configurations/routes/route_names.dart';
import 'package:telegram/core/utils/loader.dart';
import 'package:telegram/core/utils/show_snackbar.dart';
import 'package:telegram/core/utils/size.dart';
import 'package:telegram/core/utils/text_styles.dart';
import 'package:telegram/features/auth/presentation/bloc/auth_bloc.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.verificationId});
  final String verificationId;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void verifyOtp() {
    print("verify otp");
    BlocProvider.of<AuthBloc>(context).add(
      VerifyOtpEvent(
        verificationId: widget.verificationId,
        smsCode: _otpController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
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
                  onChanged: (val) {
                    if (val.length == 6) {
                      verifyOtp();
                    }
                  },
                ),
                const Spacer(flex: 6),
                SizedBox(
                  width: ScreenUtil.getSize(context).width * 0.75,
                  child: BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is Authenticated) {
                        context.goNamed(RouteNames.home);
                      } else if (state is AuthFailure) {
                        showSnackbar(context, state.message);
                        context.goNamed(RouteNames.auth);
                      }
                    },
                    builder: (context, state) {
                      return CustomButton(
                        onTap: verifyOtp,
                        text: "Go to home",
                        child: state is VerifyingOtpState
                            ? const Loader()
                            : null,
                      );
                    },
                  ),
                ),
                const Spacer(),
              ],
            ),
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
