import 'package:flutter/material.dart';

class WidthSpacer extends StatelessWidget {
  const WidthSpacer({
    super.key,
    this.width = 12,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}
