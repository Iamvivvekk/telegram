import 'package:flutter/material.dart';
import 'package:telegram/core/configurations/colors.dart';

class Loader extends StatelessWidget {
  const Loader({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          color: color ?? AppColor.appBarColor,
        ),
      ),
    );
  }
}
