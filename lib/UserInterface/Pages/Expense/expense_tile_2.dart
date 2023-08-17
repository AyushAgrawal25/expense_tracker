import 'package:expense_tracker/Models/expense_data.dart';
import 'package:expense_tracker/Models/transaction_data.dart';
import 'package:expense_tracker/UserInterface/Theme/AppTheme.dart';
import 'package:expense_tracker/Utils/date_time_utils.dart';
import 'package:flutter/material.dart';

class ExpenseTile extends StatefulWidget {
  const ExpenseTile({
    super.key,
    required this.expense,
  });

  final ExpenseData expense;

  @override
  State<ExpenseTile> createState() => _ExpenseTileState();
}

class _ExpenseTileState extends State<ExpenseTile> {
  @override
  Widget build(BuildContext context) {
    Color? primaryTextColor = Colors.white;
    const Color secondaryTextColor = Color.fromARGB(255, 118, 118, 118);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.themeColor,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.05).withOpacity(0.03),
            offset: const Offset(-10, -10),
            spreadRadius: 0,
            blurRadius: 10,
          ),
          BoxShadow(
            color: Colors.black87.withOpacity(0.3),
            offset: const Offset(10, 10),
            spreadRadius: 0,
            blurRadius: 10,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 12,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lunch_dining_outlined,
                    color: primaryTextColor,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      widget.expense.title,
                      style: TextStyle(color: primaryTextColor, fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    '₹ ${widget.expense.totalAmount.toString()}',
                    style: TextStyle(color: primaryTextColor, fontSize: 22),
                  ),
                  Icon(
                    (widget.expense.transactionType == TransactionType.credit)
                        ? Icons.arrow_upward
                        : Icons.arrow_downward,
                    color: (widget.expense.transactionType ==
                            TransactionType.credit)
                        ? Colors.green[800]
                        : Colors.red[800],
                    size: 22,
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 12,
              ),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    DateTimeUtils.getLocaleDate(widget.expense.expenseDate),
                    style: const TextStyle(color: secondaryTextColor),
                  )),
                  Text(
                    DateTimeUtils.getLocalTimeIn12HourFormat(
                        widget.expense.expenseDate),
                    style: const TextStyle(color: secondaryTextColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
