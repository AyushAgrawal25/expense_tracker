import 'package:expense_tracker/UserInterface/Widgets/AppBar/navigate_back_appbar.dart';
import 'package:expense_tracker/UserInterface/Widgets/TextField/text_field.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/Models/transaction_data.dart';
import 'package:expense_tracker/UserInterface/Widgets/AppSpecific/category_badge.dart';
import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:expense_tracker/UserInterface/Theme/AppTheme.dart';
import 'package:expense_tracker/UserInterface/Widgets/AppSpecific/transaction_details_item.dart';
import 'package:expense_tracker/Utils/date_time_utils.dart';
import 'package:expense_tracker/Models/expense_data.dart';
import 'package:expense_tracker/Models/sms_transaction_data.dart';

class ExpenseInfoForm extends StatefulWidget {
  const ExpenseInfoForm({super.key});

  @override
  State<ExpenseInfoForm> createState() => _ExpenseInfoFormState();
}

class _ExpenseInfoFormState extends State<ExpenseInfoForm> {
  @override
  Widget build(BuildContext context) {
    final ExpenseData expense =
        ModalRoute.of(context)!.settings.arguments as ExpenseData;
    final SMSTransactionData smsTransactionDetails =
        expense.transaction as SMSTransactionData;
    return Scaffold(
      backgroundColor: AppTheme.themeColor,
      appBar: const NavigateBackBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: IntrinsicWidth(
                  child: AppThemeTextField(
                    initText: expense.title.toString(),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Effective Amount',
                style: TextStyle(
                  color: AppTheme.tertiaryTextColor,
                  fontSize: 20.5,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ClayContainer(
                borderRadius: 7,
                depth: 40,
                spread: 1,
                color: AppTheme.themeColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IntrinsicWidth(
                        child: AppThemeTextField(
                          initText: '₹${expense.effectiveAmount.toString()}',
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        (expense.transactionType == TransactionType.credit)
                            ? Icons.arrow_upward
                            : Icons.arrow_downward,
                        color:
                            (expense.transactionType == TransactionType.credit)
                                ? AppTheme.successGreen
                                : AppTheme.errorRed,
                        size: 22,
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
                categoryName: Text(
                  'Food',
                  style: TextStyle(
                    color: AppTheme.tertiaryTextColor,
                    fontSize: 18.5,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'description',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppTheme.tertiaryTextColor,
                    fontSize: 20.5,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: IntrinsicWidth(
                  child: AppThemeTextField(
                    initText: (expense.description == null)
                        ? 'No Description Available'
                        : expense.description,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              _getTransactionDetailItemRow(labels: const [
                'Expense Date',
                'Spent On'
              ], initTexts: [
                DateTimeUtils.getLocaleDate(expense.expenseDate).toString(),
                expense.spentOn.toString()
              ]),
              _getTransactionDetailItemRow(labels: const [
                'Transaction Type',
                'Total Amount'
              ], initTexts: [
                expense.transactionType.name,
                '₹${expense.totalAmount.toString()}'
              ]),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: ClayContainer(
                  emboss: true,
                  width: double.infinity,
                  borderRadius: 10,
                  // depth: 10,
                  spread: 3,
                  color: AppTheme.themeColor,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 10.0),
                      child: ClayText(
                        "Transaction Info",
                        emboss: true,
                        size: 25,
                        depth: 10,
                        spread: 5,
                        textColor: AppTheme.textColor,
                        color: AppTheme.themeColor,
                      ),
                    ),
                  ),
                ),
              ),
              _getTransactionInfoDetailItem(
                label: 'medium',
                value: (smsTransactionDetails).medium.name.toString(),
              ),
              _getTransactionInfoDetailItem(
                label: 'reference no.',
                value: (smsTransactionDetails).referenceNumber,
              ),
              _getTransactionInfoDetailItem(
                label: 'amount',
                value: (smsTransactionDetails).amount.toString(),
              ),
              _getTransactionInfoDetailItem(
                label: 'receiver',
                value: (smsTransactionDetails).receiver.toString(),
              ),
              _getTransactionInfoDetailItem(
                label: 'sender',
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
    );
  }

  Widget _getTransactionInfoDetailItem(
      {required label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppTheme.tertiaryTextColor,
              fontSize: 19.5,
            ),
          ),
          const Spacer(),
          IntrinsicWidth(
            child: AppThemeTextField(
              initText: value,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getTransactionDetailItemRow(
      {required List<String> labels, required List<String> initTexts}) {
    return Row(
      children: [
        Expanded(
            child: _getTransactionDetailItemFormField(
                label: labels[0], initText: initTexts[0])),
        Expanded(
            child: _getTransactionDetailItemFormField(
                label: labels[1], initText: initTexts[1]))
      ],
    );
  }

  Widget _getTransactionDetailItemFormField(
      {required String label, required String initText}) {
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
            IntrinsicWidth(
              child: AppThemeTextField(
                initText: initText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
