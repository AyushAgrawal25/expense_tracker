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
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              label,
              style: const TextStyle(
                  color: AppTheme.tertiaryTextColor, fontSize: 19.5),
            ),
            Text(
              value,
              style: const TextStyle(color: AppTheme.textColor, fontSize: 19.5),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionDetailsRow extends StatelessWidget {
  const TransactionDetailsRow(
      {super.key, required this.labels, required this.values});

  final List<String> labels;
  final List<String> values;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TransactionDetailItem(label: labels[0], value: values[0])),
        Expanded(
            child: TransactionDetailItem(label: labels[1], value: values[1]))
      ],
    );
  }
}
