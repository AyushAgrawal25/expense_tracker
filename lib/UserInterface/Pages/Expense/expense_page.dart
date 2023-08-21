import 'package:expense_tracker/Models/transaction_data.dart';
import 'package:expense_tracker/UserInterface/Pages/Expense/expense_info_form.dart';
import 'package:expense_tracker/UserInterface/Widgets/AppSpecific/category_badge.dart';
import 'package:expense_tracker/UserInterface/Widgets/Container/neu_container.dart';
import 'package:expense_tracker/UserInterface/Widgets/Texts/info_text.dart';
import 'package:expense_tracker/UserInterface/Widgets/Texts/neu_text.dart';
import 'package:expense_tracker/UserInterface/Widgets/FloatingActionButton/custom_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/Models/sms_transaction_data.dart';
import 'package:expense_tracker/UserInterface/Theme/AppTheme.dart';
import 'package:expense_tracker/UserInterface/Widgets/AppSpecific/transaction_details_item.dart';
import 'package:expense_tracker/UserInterface/Widgets/AppBar/neu_back_appbar.dart';
import 'package:expense_tracker/Models/expense_data.dart';
import 'package:expense_tracker/Utils/date_time_utils.dart';

class ExpensePage extends StatefulWidget {
  final ExpenseData expense;
  const ExpensePage({
    Key? key,
    required this.expense,
  }) : super(key: key);

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  @override
  Widget build(BuildContext context) {
    final SMSTransactionData smsTransactionDetails =
        widget.expense.transaction as SMSTransactionData;
    return Scaffold(
      backgroundColor: AppTheme.themeColor,
      appBar: const NeuBackBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InfoText(
                widget.expense.title,
                color: AppTheme.textColor,
                fontSize: AppTheme.sh5,
              ),
              const SizedBox(
                height: 20,
              ),
              const InfoText(
                'Effective Amount',
                color: AppTheme.tertiaryTextColor,
                fontSize: AppTheme.mediumText,
              ),
              const SizedBox(
                height: 12.5,
              ),
              NeuContainer(
                radius: 7,
                depth: 40,
                spread: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      NeuText(
                        '₹ ${widget.expense.effectiveAmount.toString()}',
                        emboss: true,
                        size: AppTheme.sh4,
                        depth: 10,
                        spread: 5,
                        textColor: AppTheme.textColor,
                        color: AppTheme.themeColor,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        (widget.expense.transactionType ==
                                TransactionType.credit)
                            ? Icons.arrow_upward
                            : Icons.arrow_downward,
                        color: (widget.expense.transactionType ==
                                TransactionType.credit)
                            ? AppTheme.successGreen
                            : AppTheme.errorRed,
                        size: AppTheme.sh5,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const CategoryBadge(
                categoryIcon: Icon(
                  Icons.restaurant_outlined,
                  size: 40,
                  color: AppTheme.textColor,
                ),
                categoryName: InfoText(
                  'Food',
                  color: AppTheme.tertiaryTextColor,
                  fontSize: AppTheme.mediumText,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TransactionDetailItem(
                  label: 'Description',
                  value: (widget.expense.description == null)
                      ? 'No Description Available'
                      : widget.expense.description!,
                  alignment: CrossAxisAlignment.start,
                ),
              ),
              Row(
                children: [
                  TransactionDetailItem(
                    label: 'Expense Date',
                    value:
                        DateTimeUtils.getLocaleDate(widget.expense.expenseDate)
                            .toString(),
                    alignment: CrossAxisAlignment.start,
                  ),
                  const Spacer(),
                  TransactionDetailItem(
                    label: 'Spent On',
                    value: widget.expense.spentOn.toString(),
                    alignment: CrossAxisAlignment.end,
                  ),
                ],
              ),
              Row(
                children: [
                  TransactionDetailItem(
                    label: 'Transaction Type',
                    value: widget.expense.transactionType.name,
                    alignment: CrossAxisAlignment.start,
                  ),
                  const Spacer(),
                  TransactionDetailItem(
                    label: 'Total Amount',
                    value: '₹ ${widget.expense.totalAmount.toString()}',
                    alignment: CrossAxisAlignment.end,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 10.0,
                    ),
                    child: NeuText(
                      "Transaction Info",
                      emboss: true,
                      size: AppTheme.sh5,
                      depth: 10,
                      spread: 5,
                      textColor: AppTheme.textColor,
                      color: AppTheme.themeColor,
                    ),
                  ),
                ),
              ),
              _getTransactionInfoDetailItem(
                label: 'Medium',
                value: (smsTransactionDetails).formattedMedium,
              ),
              _getTransactionInfoDetailItem(
                label: 'Reference No.',
                value: (smsTransactionDetails).referenceNumber,
              ),
              _getTransactionInfoDetailItem(
                label: 'Amount',
                value: (smsTransactionDetails).amount.toString(),
              ),
              _getTransactionInfoDetailItem(
                label: 'Receiver',
                value: (smsTransactionDetails).receiver.toString(),
              ),
              _getTransactionInfoDetailItem(
                label: 'Sender',
                value: (smsTransactionDetails).sender.toString(),
              ),
              _getTransactionInfoDetailItem(
                label: 'Bank Name',
                value: (smsTransactionDetails).associatedBankName.toString(),
              ),
              const SizedBox(
                height: 80,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: AppThemeFloatingActionButton(
        icon: Icon(
          Icons.edit,
          color: AppTheme.successGreen,
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return ExpenseInfoForm(
                expense: widget.expense,
              );
            },
          ));
        },
      ),
    );
  }

  Widget _getTransactionInfoDetailItem(
      {required label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          InfoText(
            label,
            color: AppTheme.tertiaryTextColor,
            fontSize: AppTheme.mediumText,
          ),
          const Spacer(),
          InfoText(
            value,
            color: AppTheme.textColor,
            fontSize: AppTheme.mediumText,
          ),
        ],
      ),
    );
  }
}
