import 'package:expense_tracker/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';

class InfoText extends StatelessWidget {
  final String data;
  final double fontSize;
  final Color color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  const InfoText(
    this.data, {
    super.key,
    this.fontSize = 17.5,
    this.color = AppTheme.textColor,
    this.fontWeight,
    this.textAlign,
    this.overflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      textScaleFactor: 1.0,
    );
  }
}
