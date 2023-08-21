<<<<<<< HEAD
=======
import 'package:expense_tracker/UserInterface/Pages/Expense/expense_info_form.dart';
import 'package:expense_tracker/UserInterface/Pages/Expense/expense_page.dart';
>>>>>>> ExpenseInfoForm
import 'package:flutter/material.dart';
import 'package:expense_tracker/UserInterface/Pages/Home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SMS Inbox App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
<<<<<<< HEAD
=======
      routes: {
        '/expensepage': (context) => ExpensePage(),
        '/formpage': (context) => ExpenseInfoForm(),
      },
>>>>>>> ExpenseInfoForm
      home: const HomePage(),
    );
  }
}
