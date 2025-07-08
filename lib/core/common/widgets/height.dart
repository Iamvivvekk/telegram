import 'package:flutter/material.dart';

class HeightSpacer extends StatelessWidget {
  const HeightSpacer({
    super.key,
    this.height = 12,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
