import 'package:expense_tracker/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';

class TransactionDetailItem extends StatelessWidget {
  const TransactionDetailItem(
      {super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
                fontSize: 20.5, color: AppTheme.tertiaryTextColor),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontSize: 20.5, color: AppTheme.textColor),
          )
        ],
      ),
    );
  }
}
