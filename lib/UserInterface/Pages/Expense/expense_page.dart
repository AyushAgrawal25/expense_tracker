import 'package:expense_tracker/Models/transaction_data.dart';
import 'package:expense_tracker/UserInterface/Widgets/AppSpecific/category_badge.dart';
import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:expense_tracker/Models/sms_transaction_data.dart';
import 'package:expense_tracker/UserInterface/Theme/AppTheme.dart';
import 'package:expense_tracker/UserInterface/Widgets/AppSpecific/transaction_details_item.dart';
import 'package:expense_tracker/UserInterface/Widgets/AppBar/navigate_back_appbar.dart';
import 'package:expense_tracker/Models/expense_data.dart';
import 'package:expense_tracker/Utils/date_time_utils.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
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
              Text(
                expense.title,
                style: const TextStyle(
                  color: AppTheme.textColor,
                  fontSize: 22.5,
                ),
              ),
              const SizedBox(
                height: 30,
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClayText(
                        '₹${expense.effectiveAmount.toString()}',
                        emboss: true,
                        size: 25,
                        depth: 10,
                        spread: 5,
                        textColor: AppTheme.textColor,
                        color: AppTheme.themeColor,
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
                                ? Colors.green[800]
                                : Colors.red[800],
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
                height: 20,
              ),
              const SizedBox(
                height: 20,
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
              const SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  (expense.description == null)
                      ? 'No Description Available'
                      : expense.description!,
                  style: const TextStyle(
                    color: AppTheme.textColor,
                    fontSize: 19.5,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TransactionDetailsRow(labels: const [
                'Expense Date',
                'Spent On'
              ], values: [
                DateTimeUtils.getLocaleDate(expense.expenseDate).toString(),
                expense.spentOn.toString()
              ]),
              TransactionDetailsRow(labels: const [
                'Transaction Type',
                'Total Amount'
              ], values: [
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
                height: 20,
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
      padding: const EdgeInsets.symmetric(vertical: 10.0),
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
          Text(
            value,
            style: const TextStyle(
              color: AppTheme.textColor,
              fontSize: 19.5,
            ),
          ),
        ],
      ),
    );
  }
}
