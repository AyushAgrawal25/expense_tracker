import 'dart:convert';

import 'package:expense_tracker/Models/expense_data.dart';
import 'package:expense_tracker/Models/sms_transaction_data.dart';
import 'package:expense_tracker/UserInterface/Pages/Loader/loader_page.dart';
import 'package:expense_tracker/UserInterface/Theme/AppTheme.dart';
import 'package:expense_tracker/Utils/logger_utils.dart';
import 'package:expense_tracker/Utils/sms_transaction_utils.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/UserInterface/Pages/Expense/expense_tile.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:expense_tracker/Utils/sms_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ExpenseData> expenses = [];
  bool isLoading = false;
  double totalExpense = 0;

  @override
  void initState() {
    extractExpenses();
    super.initState();
  }

  extractExpenses() async {
    setState(() {
      isLoading = true;
      expenses = [];
      totalExpense = 0;
    });

    List<SmsMessage> messages = await SMSUtils.getSMS();
    logger.i('Total Messages: ${messages.length}');

    int id = 0;
    expenses = [];
    for (var msg in messages) {
      if (msg.body == null) {
        continue;
      }

      SMSTransactionData? smsTransactionData =
          SMSTransactionUtils.getTransactionData(
        msg.body!,
        msg.date == null ? DateTime.now() : msg.date!,
        id,
      );
      if (smsTransactionData != null) {
        expenses.add(ExpenseData.fromSMSTransaction(
          id,
          smsTransactionData,
        ));
        totalExpense += smsTransactionData.amount;
        id++;
      }
    }

    logger.i('Total Expenses: ${expenses.length}');
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.themeColor,
      appBar: AppBar(
        backgroundColor: AppTheme.themeColor,
        title: const Text('Expense Tracker'),
      ),
      body: (isLoading)
          ? const LoaderPage()
          : Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: ListView.builder(
                  itemCount: expenses.length,
                  itemBuilder: (context, index) {
                    return ExpenseTile(
                      expense: expenses[index],
                    );
                  }),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: onRefreshPressed,
        child: const Icon(Icons.refresh),
      ),
    );
  }

  void onRefreshPressed() async {
    extractExpenses();
  }
}
