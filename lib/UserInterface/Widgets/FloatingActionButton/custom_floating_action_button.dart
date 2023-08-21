import 'package:clay_containers/clay_containers.dart';
import 'package:expense_tracker/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';

class AppThemeFloatingActionButton extends StatefulWidget {
  const AppThemeFloatingActionButton(
      {super.key, required this.icon, required this.onTap});

  final Icon icon;
  final void Function() onTap;

  @override
  State<AppThemeFloatingActionButton> createState() =>
      _AppThemeFloatingActionButtonState();
}

class _AppThemeFloatingActionButtonState
    extends State<AppThemeFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InkWell(
        onTap: widget.onTap,
        child: ClayContainer(
          color: AppTheme.themeColor,
          spread: 2,
          depth: 30,
          borderRadius: 50,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: widget.icon,
          ),
        ),
      ),
    );
  }
}
