import 'package:expense_tracker/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';

class TransactionDetailItem extends StatelessWidget {
  final String label;
  final String value;
  final CrossAxisAlignment alignment;

  const TransactionDetailItem({
    super.key,
    required this.label,
    required this.value,
    this.alignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppTheme.tertiaryTextColor,
              fontSize: 15,
            ),
            textAlign: (alignment == CrossAxisAlignment.start)
                ? TextAlign.left
                : TextAlign.right,
          ),
          const SizedBox(
            height: 3.5,
          ),
          Text(
            value,
            style: const TextStyle(
              color: AppTheme.textColor,
              fontSize: 17.5,
            ),
            textAlign: (alignment == CrossAxisAlignment.start)
                ? TextAlign.left
                : TextAlign.right,
          ),
        ],
      ),
    );
  }
}
