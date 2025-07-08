import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telegram/core/configurations/colors.dart';

TextStyle normalText({
  double fontsize = 14,
  FontWeight fontWeight = FontWeight.normal,
  Color color = AppColor.white,
}) {
  return GoogleFonts.poppins(
    fontSize: fontsize,
    fontWeight: fontWeight,
    color: color,
  );
}

TextStyle greyText({
  double fontsize = 14,
  FontWeight fontWeight = FontWeight.normal,
  Color color = AppColor.greyText,
}) {
  return GoogleFonts.poppins(
    fontSize: fontsize,
    fontWeight: fontWeight,
    color: color,
  );
}
