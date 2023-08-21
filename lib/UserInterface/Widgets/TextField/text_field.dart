import 'package:expense_tracker/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';

class AppThemeTextField extends StatefulWidget {
  const AppThemeTextField({super.key, this.label, this.initText = ""});

  final Widget? label;
  final String? initText;
  @override
  State<AppThemeTextField> createState() => _AppThemeTextFieldState();
}

class _AppThemeTextFieldState extends State<AppThemeTextField> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.initText);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      decoration: InputDecoration(
        label: widget.label,
        labelStyle: const TextStyle(color: AppTheme.tertiaryTextColor),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),
      style: const TextStyle(
        color: AppTheme.textColor, // You can adjust the color here
        fontSize: 19.5,
      ),
    );
  }
}
