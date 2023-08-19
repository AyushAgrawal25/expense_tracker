import 'package:clay_containers/clay_containers.dart';
import 'package:expense_tracker/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';

class NeuText extends StatelessWidget {
  final String data;
  final double size;
  final bool? emboss;
  final Color color;
  final Color textColor;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final int? maxLines;
  final int? depth;
  final double? spread;

  const NeuText(
    this.data, {
    super.key,
    this.emboss,
    this.size = 17.5,
    this.color = AppTheme.textColor,
    this.textColor = AppTheme.themeColor,
    this.fontWeight,
    this.overflow,
    this.maxLines,
    this.depth,
    this.spread,
  });

  @override
  Widget build(BuildContext context) {
    return ClayText(
      data,
      style: TextStyle(
        fontWeight: fontWeight,
        overflow: overflow,
      ),
      color: color,
      size: size,
      textColor: textColor,
      depth: depth,
      spread: spread,
      emboss: emboss,
    );
  }
}
