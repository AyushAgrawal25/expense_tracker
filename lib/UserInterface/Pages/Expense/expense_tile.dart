import 'package:expense_tracker/Models/expense_data.dart';
import 'package:expense_tracker/Models/transaction_data.dart';
import 'package:expense_tracker/UserInterface/Theme/AppTheme.dart';
import 'package:expense_tracker/Utils/date_time_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpenseTile extends StatefulWidget {
  const ExpenseTile({
    Key? key,
    required this.expense,
  }) : super(key: key);

  final ExpenseData expense;
  @override
  State<ExpenseTile> createState() => _ExpenseTileState();
}

class _ExpenseTileState extends State<ExpenseTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: AppTheme.themeColor,
        boxShadow: [
          BoxShadow(
              color: Colors.white.withOpacity(0.05).withOpacity(0.03),
              offset: const Offset(-10, -10),
              spreadRadius: 0,
              blurRadius: 10),
          BoxShadow(
              color: Colors.black87.withOpacity(0.3),
              offset: const Offset(10, 10),
              spreadRadius: 0,
              blurRadius: 10),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 15,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /**
             * Category Icon
             */
            const Icon(
              Icons.lunch_dining_outlined,
              color: AppTheme.textColor,
              size: 30,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /**
                   *  Expense Title and Amount
                   */
                  Row(
                    children: [
                      /**
                       * Expense Title
                       */
                      Expanded(
                        child: Text(
                          widget.expense.title,
                          style: const TextStyle(
                            color: AppTheme.textColor,
                            fontSize: 17.5,
                          ),
                        ),
                      ),

                      /**
                       * Expense Amount
                       */
                      Text(
                        '₹ ${widget.expense.effectiveAmount}',
                        style: const TextStyle(
                          color: AppTheme.textColor,
                          fontSize: 17.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 3.5,
                  ),

                  /**
                   * Expense Date and Time
                   */
                  Row(
                    children: [
                      /**
                       * Expense Date
                       */
                      Expanded(
                        child: Text(
                          DateTimeUtils.getLocaleDate(
                              widget.expense.expenseDate),
                          style: TextStyle(
                            color: AppTheme.secondaryTextColor,
                            fontSize: 12.5,
                          ),
                        ),
                      ),
                      /**
                       * Expense Time
                       */
                      Text(
                        DateTimeUtils.getLocalTimeIn12HourFormat(
                            widget.expense.expenseDate),
                        style: TextStyle(
                          color: AppTheme.secondaryTextColor,
                          fontSize: 12.5,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),

            /**
             * Transaction Type Icon
             */
            Icon(
              (widget.expense.transactionType == TransactionType.credit)
                  ? Icons.arrow_upward
                  : Icons.arrow_downward,
              color: (widget.expense.transactionType == TransactionType.credit)
                  ? Colors.green[800]
                  : Colors.red[800],
              size: 27.5,
            )
          ],
        ),
      ),
    );
  }
}
