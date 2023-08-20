import 'package:expense_tracker/UserInterface/Theme/AppTheme.dart';
import 'package:expense_tracker/UserInterface/Widgets/Texts/info_text.dart';
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
          InfoText(
            label,
            fontSize: AppTheme.smallText,
            color: AppTheme.tertiaryTextColor,
            textAlign: (alignment == CrossAxisAlignment.start)
                ? TextAlign.left
                : TextAlign.right,
          ),
          const SizedBox(
            height: 3.5,
          ),
          InfoText(
            value,
            fontSize: AppTheme.mediumText,
            color: AppTheme.textColor,
            textAlign: (alignment == CrossAxisAlignment.start)
                ? TextAlign.left
                : TextAlign.right,
          ),
        ],
      ),
    );
  }
}
