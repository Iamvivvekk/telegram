import 'package:flutter/material.dart';
import 'package:telegram/core/configurations/colors.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.blueSecondary,
      child: Center(
        child: Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(color: AppColor.white),
        ),
      ),
    );
  }
}
