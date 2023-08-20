import 'package:expense_tracker/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';

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
    return ClayContainer(
      color: AppTheme.themeColor,
      borderRadius: 10,
      depth: 10,
      spread: 5,
      emboss: true,
      child: Container(
        width: 85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppTheme.themeColor,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 3.5,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedValue,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            onChanged: (String? newValue) {
              setState(() {
                if (newValue == null) return;
                selectedValue = newValue;
                widget.onSelect(newValue);
              });
            },
            isDense: true,
            isExpanded: true,
            dropdownColor: AppTheme.themeColor,
            items: widget.options
                .map<DropdownMenuItem<String>>(
                  (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                      padding: const EdgeInsets.only(left: 15),
                      color: AppTheme.themeColor,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        value,
                        style: const TextStyle(
                          color: AppTheme.textColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
