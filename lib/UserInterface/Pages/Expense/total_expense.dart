import 'package:expense_tracker/UserInterface/Theme/AppTheme.dart';
import 'package:expense_tracker/UserInterface/Widgets/Texts/info_text.dart';
import 'package:expense_tracker/Utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/UserInterface/Widgets/Dropdowns/custom_dropdown.dart';

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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const InfoText(
                    'Total Spend',
                    color: AppTheme.tertiaryTextColor,
                    fontSize: AppTheme.mediumText,
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
              const SizedBox(
                height: 5,
              ),
              InfoText(
                "₹ ${totalExpense.toStringAsFixed(2)}",
                color: AppTheme.textColor,
                fontSize: AppTheme.h4,
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
