import 'package:expense_tracker/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';

class NeomorphicDropdownButton extends StatefulWidget {
  const NeomorphicDropdownButton({
    super.key,
    required this.options,
    required this.initialSelected,
    required this.onSelect,
  });

  final List<String> options;
  final String initialSelected;
  final void Function(String month) onSelect;

  @override
  State<NeomorphicDropdownButton> createState() =>
      _NeomorphicDropdownButtonState();
}

class _NeomorphicDropdownButtonState extends State<NeomorphicDropdownButton> {
  String? selectedValue;
  @override
  void initState() {
    selectedValue = widget.initialSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
        initialSelection: selectedValue,
        dropdownMenuEntries: widget.options
            .map((item) => DropdownMenuEntry(
                  value: item,
                  label: item,
                ))
            .toList(),
        onSelected: (value) {
          setState(() {
            if (value == null) return;
            selectedValue = value;
            widget.onSelect(value);
          });
        });
  }
}
