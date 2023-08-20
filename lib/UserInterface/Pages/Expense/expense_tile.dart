import 'package:expense_tracker/Models/expense_data.dart';
import 'package:expense_tracker/Models/transaction_data.dart';
import 'package:expense_tracker/UserInterface/Pages/Expense/expense_page.dart';
import 'package:expense_tracker/UserInterface/Theme/AppTheme.dart';
import 'package:expense_tracker/UserInterface/Widgets/Container/neu_container.dart';
import 'package:expense_tracker/UserInterface/Widgets/Texts/info_text.dart';
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
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ExpensePage(
            expense: widget.expense,
          ),
        ));
      },
      child: NeuContainer(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                    const Icon(
                      Icons.lunch_dining_outlined,
                      color: AppTheme.textColor,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: InfoText(
                        widget.expense.title,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InfoText(
                      '₹ ${widget.expense.totalAmount.toString()}',
                      fontSize: AppTheme.sh5,
                    ),
                    Icon(
                      (widget.expense.transactionType == TransactionType.credit)
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      color: (widget.expense.transactionType ==
                              TransactionType.credit)
                          ? AppTheme.successGreen
                          : AppTheme.errorRed,
                      size: AppTheme.sh5,
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
                        child: InfoText(
                      DateTimeUtils.getLocaleDate(widget.expense.expenseDate),
                      color: AppTheme.tertiaryTextColor,
                      fontSize: AppTheme.smallText,
                    )),
                    InfoText(
                      DateTimeUtils.getLocalTimeIn12HourFormat(
                          widget.expense.expenseDate),
                      color: AppTheme.tertiaryTextColor,
                      fontSize: AppTheme.smallText,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
