import 'dart:convert';

import 'package:expense_tracker/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SmsQuery _query = SmsQuery();
  List<SmsMessage> _messages = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SMS Inbox App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SMS Inbox Example'),
        ),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              'Click the refresh button to get SMS messages.',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: onRefreshPressed,
          child: const Icon(Icons.refresh),
        ),
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
    print('SMS JSON isWritten: $isWritten');

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
    print('SMS String JSON isWritten: $isMessagesStringWritten');

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
    print('UPI Messages Count: $upiMessagesCount');

    String upiMessagesStringData = jsonEncode(upiMessages);
    String upiMessagesStringFilePath =
        await FileUtils.createExternalFile('upi_sms_string.json');
    bool isUPIStringWritten = await FileUtils.writeInFile(
        upiMessagesStringFilePath, upiMessagesStringData);
    print('UPI SMS String JSON isWritten: $isUPIStringWritten');
  }
}
