import 'dart:convert';

import 'package:expense_tracker/Models/expense_data.dart';
import 'package:expense_tracker/UserInterface/Theme/AppTheme.dart';
import 'package:expense_tracker/Utils/logger_utils.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/UserInterface/Pages/Expense/expense_tile.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:expense_tracker/Utils/sms_utils.dart';
import 'package:expense_tracker/Utils/file_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.themeColor,
      appBar: AppBar(
        backgroundColor: AppTheme.themeColor,
        title: const Text('Expense Tracker'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Column(
          children: [
            ...sampleExpenses.map((e) => ExpenseTile(expense: e)).toList()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onRefreshPressed,
        child: const Icon(Icons.refresh),
      ),
    );
  }

  void onRefreshPressed() async {
    List<SmsMessage> messages = await SMSUtils.getSMS();
    List<Map<String, dynamic>> messagesMap = [];
    for (SmsMessage message in messages) {
      String smsKind = "";
      if (message.kind == SmsMessageKind.sent) {
        smsKind = "sent";
      } else if (message.kind == SmsMessageKind.received) {
        smsKind = "received";
      } else if (message.kind == SmsMessageKind.draft) {
        smsKind = "draft";
      }
      messagesMap.add({
        'id': message.id,
        'threadId': message.threadId,
        'address': message.address,
        'body': message.body,
        'read': message.read,
        'date':
            message.date != null ? message.date!.millisecondsSinceEpoch : null,
        'dateSent': message.dateSent != null
            ? message.dateSent!.millisecondsSinceEpoch
            : null,
        'kind': smsKind,
      });
    }

    String smsData = jsonEncode(messagesMap);
    String filePath = await FileUtils.createExternalFile('sms.json');
    bool isWritten = await FileUtils.writeInFile(filePath, smsData);
    logger.i('SMS JSON isWritten: $isWritten');

    List<String> messagesString = [];
    for (SmsMessage message in messages) {
      if (message.body != null) {
        messagesString.add(message.body!);
      }
    }

    String messagesStringData = jsonEncode(messagesString);
    String messagesStringFilePath =
        await FileUtils.createExternalFile('sms_string.json');
    bool isMessagesStringWritten =
        await FileUtils.writeInFile(messagesStringFilePath, messagesStringData);
    logger.i('SMS String JSON isWritten: $isMessagesStringWritten');

    // UPI Messages Count.
    List<String> upiMessages = [];
    int upiMessagesCount = 0;
    for (SmsMessage message in messages) {
      if (message.body != null) {
        if (message.body!.contains('UPI')) {
          upiMessagesCount++;
          upiMessages.add(message.body!);
        }
      }
    }
    logger.i('UPI Messages Count: $upiMessagesCount');

    String upiMessagesStringData = jsonEncode(upiMessages);
    String upiMessagesStringFilePath =
        await FileUtils.createExternalFile('upi_sms_string.json');
    bool isUPIStringWritten = await FileUtils.writeInFile(
        upiMessagesStringFilePath, upiMessagesStringData);
    logger.i('UPI SMS String JSON isWritten: $isUPIStringWritten');
  }
}
