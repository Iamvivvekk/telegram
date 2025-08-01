import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:telegram/core/common/widgets/height.dart';
import 'package:telegram/core/configurations/colors.dart';
import 'package:telegram/core/utils/loader.dart';
import 'package:telegram/core/utils/reusable_text.dart';
import 'package:telegram/core/utils/text_styles.dart';
import 'package:telegram/features/auth/controller/auth_controller.dart';
import 'package:telegram/features/auth/controller/country_picker_provider.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _countryController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late Country country;

  @override
  void initState() {
    country = ref.read(countryPickerProvider);
    _countryController.text = "${country.flagEmoji} ${country.displayName}";
    super.initState();
  }

  @override
  void dispose() {
    _countryController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void sendOtp() async {
    if (_formKey.currentState!.validate()) {
      await ref
          .read(authControllerProvider.notifier)
          .signInWithPhone(
            context,
            "+${country.phoneCode}${_phoneController.text.trim()}",
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    country = ref.watch(countryPickerProvider);
    _countryController.text = "${country.flagEmoji} ${country.displayName}";
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ReusableText(
                  "Your phone number",
                  fontsize: 22,
                  fontWeight: FontWeight.bold,
                ),
                const HeightSpacer(),
                const ReusableText(
                  "Please confirm your country code and enter your phone number",
                  textAlign: TextAlign.center,

                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 122, 119, 119),
                ),
                const HeightSpacer(),
                Consumer(
                  builder: (context, ref, _) {
                    return TextFormField(
                      controller: _countryController,
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          onSelect: (value) {
                            ref.read(countryPickerProvider.notifier).state =
                                value;
                          },
                        );
                      },
                      readOnly: true,
                      decoration: const InputDecoration(
                        label: Text("Country"),
                        suffixIcon: Icon(Icons.navigate_next_outlined),
                      ),
                    );
                  },
                ),
                const HeightSpacer(height: 20),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  style: const TextStyle(letterSpacing: 1.2),
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                  decoration: InputDecoration(
                    hintStyle: normalText().copyWith(letterSpacing: 1.2),
                    counterText: "",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text("+ ${country.phoneCode}"),
                            ),
                            const ReusableText("|", fontsize: 18),
                          ],
                        ),
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                    hintText: "00000 00000",
                    label: const Text("Phone"),
                  ),
                  validator: (val) {
                    if (val == null) {
                      return 'please enter phone number';
                    }
                    if (val.isEmpty) {
                      return 'please enter phone number';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.primary,
          shape: const CircleBorder(),
          onPressed: () => sendOtp(),
          child: ref.watch(authControllerProvider)
              ? const Loader(color: AppColor.white)
              : const Icon(Icons.arrow_forward, color: AppColor.white),
        ),
      ),
    );
  }
}
