import 'package:flutter/material.dart';
import 'package:expense_tracker/UserInterface/Theme/AppTheme.dart';
import 'package:clay_containers/clay_containers.dart';

class NeuContainer extends StatefulWidget {
  const NeuContainer({
    super.key,
    required this.child,
    this.margin,
    this.width,
    this.height,
    this.spread = 3,
    this.depth = 20,
    this.emboss = false,
    this.radius = 10,
  });

  final Widget child;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final double spread;
  final int depth;
  final bool emboss;
  final double radius;

  @override
  State<NeuContainer> createState() => _NeuContainerState();
}

class _NeuContainerState extends State<NeuContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? const EdgeInsets.all(0),
      child: ClayContainer(
        emboss: widget.emboss,
        width: widget.width,
        height: widget.height,
        spread: widget.spread,
        depth: widget.depth,
        borderRadius: widget.radius,
        color: AppTheme.themeColor,
        child: widget.child,
      ),
    );
  }
}
