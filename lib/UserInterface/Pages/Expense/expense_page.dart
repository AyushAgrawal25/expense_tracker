import 'package:clay_containers/clay_containers.dart';
import 'package:expense_tracker/Models/sms_transaction_data.dart';
import 'package:expense_tracker/UserInterface/Theme/AppTheme.dart';
import 'package:expense_tracker/UserInterface/Widgets/transaction_details_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/UserInterface/Widgets/AppBar/navigate_back_appbar.dart';
import 'package:expense_tracker/Models/expense_data.dart';
import 'package:expense_tracker/Utils/date_time_utils.dart';

class ExpensePage extends StatelessWidget {
  const ExpensePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ExpenseData expense =
        ModalRoute.of(context)!.settings.arguments as ExpenseData;

    final SMSTransactionData smsTransactionDetails =
        expense.transaction as SMSTransactionData;
    return Scaffold(
      backgroundColor: AppTheme.themeColor,
      appBar: const NavigateBackBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            TransactionDetailItem(
              label: 'title',
              value: expense.title,
            ),
            TransactionDetailItem(
              label: 'description',
              value: (expense.description == null)
                  ? 'No Description Available'
                  : expense.description!,
            ),
            TransactionDetailItem(
              label: 'Total Amount',
              value: expense.totalAmount.toString(),
            ),
            TransactionDetailItem(
              label: 'Effective Amount',
              value: expense.effectiveAmount.toString(),
            ),
            TransactionDetailItem(
              label: 'Expense Date',
              value:
                  DateTimeUtils.getLocaleDate(expense.expenseDate).toString(),
            ),
            TransactionDetailItem(
              label: 'Transaction Type',
              value: expense.transactionType.name,
            ),
            TransactionDetailItem(
              label: 'Spent On',
              value: expense.spentOn.toString(),
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
                      textColor: AppTheme.tertiaryTextColor,
                      color: AppTheme.themeColor,
                    ),
                  ),
                ),
              ),
            ),
            TransactionDetailItem(
              label: 'medium',
              value: (smsTransactionDetails).medium.name.toString(),
            ),
            TransactionDetailItem(
              label: 'reference no.',
              value: (smsTransactionDetails).referenceNumber,
            ),
            TransactionDetailItem(
              label: 'amount',
              value: (smsTransactionDetails).amount.toString(),
            ),
            TransactionDetailItem(
              label: 'receiver',
              value: (smsTransactionDetails).receiver.toString(),
            ),
            TransactionDetailItem(
              label: 'sender',
              value: (smsTransactionDetails).sender.toString(),
            ),
            TransactionDetailItem(
              label: 'Bank Name',
              value: (smsTransactionDetails).associatedBankName.toString(),
            ),
          ],
        ),
      ),
    );
  }
}
