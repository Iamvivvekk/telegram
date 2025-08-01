import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telegram/core/configurations/colors.dart';
import 'package:telegram/core/utils/text_styles.dart';

class AppTheme {
  static ThemeData darkTheme(BuildContext context) {
    OutlineInputBorder border({Color color = AppColor.primary}) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColor.primary),
      );
    }

    final textTheme = Theme.of(context).textTheme;
    final theme = Theme.of(context);

    return ThemeData.dark().copyWith(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColor.background,
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        bodyLarge: textTheme.bodyLarge!.copyWith(color: AppColor.white),
        titleMedium: textTheme.titleMedium!.copyWith(
          color: theme.highlightColor,
        ),
        bodyMedium: textTheme.bodyMedium!.copyWith(color: AppColor.white),
      ),
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
        labelStyle: normalText(fontsize: 14, color: AppColor.white),
      ),
    );
  }
}

// class AppthemeController extends StateNotifier<ThemeData> {
//   AppthemeController() : super(AppTheme.darkTheme());

//   void changeTheme() {
//     state = AppTheme.darkTheme();
//   }
// }
