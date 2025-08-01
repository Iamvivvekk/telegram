import 'package:flutter/material.dart';
import 'package:telegram/core/configurations/colors.dart';
import 'package:telegram/core/utils/reusable_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    this.child,
  });
  final String text;
  final VoidCallback? onTap;
  final Widget? child; // final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColor.primary,
        ),
        child: Center(
          child:
              child ??
              ReusableText(text, fontWeight: FontWeight.w500, fontsize: 18),
        ),
      ),
    );
  }
}
