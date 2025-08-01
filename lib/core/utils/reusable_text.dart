import 'package:flutter/material.dart';

class ReusableText extends StatelessWidget {
  const ReusableText(
    this.text, {
    super.key,
    this.textAlign,
    this.color,
    this.fontWeight,
    this.fontsize,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final double? fontsize;
  final FontWeight? fontWeight;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        fontSize: fontsize,
        fontWeight: fontWeight,
        color: color,
      
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      
      overflow: overflow,
    );
  }
}
