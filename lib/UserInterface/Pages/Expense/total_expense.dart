import 'package:expense_tracker/UserInterface/Theme/AppTheme.dart';
import 'package:expense_tracker/Utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/Widgets/Dropdowns/custom_dropdown.dart';

class TotalExpense extends StatelessWidget {
  const TotalExpense({
    super.key,
    required this.totalExpense,
    required this.onMonthChanged,
  });

  final double totalExpense;
  final void Function(String month) onMonthChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 30,
        right: 30,
        top: 25,
        bottom: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Spend',
                    style: TextStyle(
                      color: AppTheme.tertiaryTextColor,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "₹ ${totalExpense.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: AppTheme.textColor,
                      fontSize: 38,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              NeomorphicDropdownButton(
                options: DateTimeUtils.getMonthsList,
                initialSelected:
                    DateTimeUtils.getMonthName(DateTime.now().month)!,
                onSelect: onMonthChanged,
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
