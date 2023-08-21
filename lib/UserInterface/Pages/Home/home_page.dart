import 'package:expense_tracker/Models/expense_data.dart';
import 'package:expense_tracker/Models/sms_transaction_data.dart';
import 'package:expense_tracker/UserInterface/Pages/Loader/loader_page.dart';
import 'package:expense_tracker/UserInterface/Theme/AppTheme.dart';
import 'package:expense_tracker/UserInterface/Widgets/Texts/info_text.dart';
import 'package:expense_tracker/Utils/date_time_utils.dart';
import 'package:expense_tracker/Utils/logger_utils.dart';
import 'package:expense_tracker/Utils/sms_transaction_utils.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/UserInterface/Pages/Expense/expense_tile.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:expense_tracker/Utils/sms_utils.dart';
import 'package:expense_tracker/UserInterface/Pages/Expense/total_expense.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ExpenseData> allExpenses = [];
  List<ExpenseData> selectedMonthExpenses = [];
  bool isLoading = false;
  double totalExpense = 0;

  @override
  void initState() {
    initExpenses();
    super.initState();
  }

  initExpenses() async {
    await extractExpenses();
    onMonthChanged(DateTimeUtils.getMonthName(DateTime.now().month)!);
  }

  extractExpenses() async {
    setState(() {
      isLoading = true;
      allExpenses = [];
      totalExpense = 0;
    });

    List<SmsMessage> messages = await SMSUtils.getSMS();
    logger.i('Total Messages: ${messages.length}');

    int id = 0;
    allExpenses = [];
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
        allExpenses.add(ExpenseData.fromSMSTransaction(
          id,
          smsTransactionData,
        ));
        id++;
      }
    }

    logger.i('Total Expenses: ${allExpenses.length}');
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
        title: const InfoText('Expense Tracker'),
      ),
      body: (isLoading)
          ? const LoaderPage()
          : Column(
              children: [
                TotalExpense(
                  totalExpense: totalExpense,
                  onMonthChanged: onMonthChanged,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: ListView.builder(
                      itemCount: selectedMonthExpenses.length,
                      itemBuilder: (context, index) {
                        return ExpenseTile(
                          expense: selectedMonthExpenses[index],
                        );
                      },
                    ),
                  ),
                ),
              ],
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

  void onMonthChanged(String month) {
    setState(() {
      selectedMonthExpenses = [];
      totalExpense = 0;
    });

    for (var expense in allExpenses) {
      if ((DateTimeUtils.getMonthName(expense.expenseDate.month) == month) &&
          (expense.expenseDate.year == DateTime.now().year)) {
        selectedMonthExpenses.add(expense);
        totalExpense += expense.effectiveAmount;
      }
    }

    setState(() {});
  }
}
