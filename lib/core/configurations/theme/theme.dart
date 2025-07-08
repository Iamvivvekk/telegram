import 'package:flutter/material.dart';
import 'package:telegram/core/configurations/colors.dart';
import 'package:telegram/core/utils/text_styles.dart';

class AppTheme {
  static ThemeData lightTheme() {
    OutlineInputBorder border({Color color = AppColor.primary}) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColor.primary),
      );
    }

    return ThemeData.dark().copyWith(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColor.background,
      appBarTheme: const AppBarTheme(
        color: AppColor.appBarColor,
        centerTitle: false,
        foregroundColor: AppColor.white,
        surfaceTintColor: AppColor.transparent,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: border(),
        focusedBorder: border(color: AppColor.darkGrey),
        enabledBorder: border(color: AppColor.darkGrey),
        floatingLabelStyle: normalText(color: AppColor.primary),
        errorBorder: border(color: AppColor.error),
        focusedErrorBorder: border(color: AppColor.error),
        hintStyle: const TextStyle(
          fontSize: 14,
          color: AppColor.white,
          fontWeight: FontWeight.w400,
        ),
        labelStyle: normalText(
          fontsize: 14,
          color: AppColor.white,
        ),
      ),
    );
  }
}
