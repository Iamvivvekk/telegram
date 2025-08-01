import 'package:flutter/material.dart';
import 'package:telegram/core/configurations/colors.dart';

TextStyle normalText({
  double fontsize = 14,
  FontWeight fontWeight = FontWeight.normal,
  Color color = AppColor.white,
}) {
  return TextStyle(fontSize: fontsize, fontWeight: fontWeight, color: color);
}

TextStyle greyText({
  double fontsize = 14,
  FontWeight fontWeight = FontWeight.normal,
  Color color = AppColor.greyText,
}) {
  return TextStyle(fontSize: fontsize, fontWeight: fontWeight, color: color);
}
