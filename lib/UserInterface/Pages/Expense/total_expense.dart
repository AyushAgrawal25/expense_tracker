import 'package:expense_tracker/UserInterface/Theme/AppTheme.dart';
import 'package:expense_tracker/Utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/Widgets/Dropdown Button/custom_dropdown.dart';

class TotalExpense extends StatefulWidget {
  const TotalExpense({
    super.key,
    required this.totalExpense,
    required this.calcExpense,
  });

  final double totalExpense;
  final void Function(String month) calcExpense;

  @override
  State<TotalExpense> createState() => _TotalExpenseState();
}

class _TotalExpenseState extends State<TotalExpense> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 30,
        right: 30,
        top: 40,
        bottom: 20,
      ),
      child: Row(
        children: [
          Column(
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
                "₹${widget.totalExpense.toStringAsFixed(2)}",
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
            initialSelected: DateTimeUtils.getMonthName(DateTime.now().month)!,
            onSelect: widget.calcExpense,
          ),
        ],
      ),
    );
  }
}
