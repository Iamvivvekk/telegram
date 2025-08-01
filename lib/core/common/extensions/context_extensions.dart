import 'package:flutter/material.dart';

extension OnBuildContext on BuildContext {
  double get safeAreaHeight => MediaQuery.of(this).padding.top;

  double get appbarHeight => kToolbarHeight;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
}

