import 'package:expense_tracker/Models/sms_transaction_data.dart';
import 'package:expense_tracker/Models/transaction_data.dart';
import 'package:expense_tracker/Utils/date_time_utils.dart';
import 'package:expense_tracker/Utils/logger_utils.dart';

class SMSTransactionUtils {
  static TransactionType? getTransactionType(String message) {
    if (message.toLowerCase().contains("debited")) {
      return TransactionType.debit;
    } else if (message.toLowerCase().contains("credited")) {
      return TransactionType.credit;
    } else {
      return null;
    }
  }

  static String? getReferenceNumber(String text) {
    final RegExp regex = RegExp(r'[R|r]ef\s?[n|N]o (\d+)');
    final Match? match = regex.firstMatch(text);
    if (match != null) {
      return match.group(1);
    } else {
      return null;
    }
  }

  static double? getAmount(String text) {
    final RegExp regex = RegExp(
        r'(?:Rs|INR|₹|debited by|credited by|debited from|credited to)\s?([\d.]+)',
        caseSensitive: false);
    final Match? match = regex.firstMatch(text);
    if (match != null) {
      return double.tryParse(match.group(1) ?? "");
    } else {
      return null;
    }
  }

  static String? getAccountNo(String text) {
    final RegExp regex = RegExp(r'[A|a]/[c|C]\s?[A-Za-z]*(\d+)');
    final Match? match = regex.firstMatch(text);

    if (match != null) {
      String accountNumber = match.group(1) ?? '';
      return accountNumber;
    } else {
      return null;
    }
  }

  static String? getBankName(String text) {
    final RegExp regex = RegExp(r'(?:\s|^)-\s?([A-Za-z]+)');
    final Match? match = regex.firstMatch(text);

    if (match != null) {
      String bankName = match.group(1) ?? '';
      return bankName;
    } else {
      return null;
    }
  }

  static DateTime? getDate(String text) {
    final RegExp regex = RegExp(
        r'(\d{2}[A-Za-z]{3}\d{2}|\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2} [APap][Mm])');
    final Match? match = regex.firstMatch(text);

    if (match != null) {
      String dateString = match.group(1) ?? '';

      if (dateString.contains("-")) {
        return DateTimeUtils.parseDateTime(dateString);
      } else {
        DateTime now = DateTime.now();
        String yearPrefix = now.year.toString().substring(0, 2);
        int day = int.parse(dateString.substring(0, 2));
        int monthIndex =
            DateTimeUtils.getMonthIndex(dateString.substring(2, 5));
        int year = int.parse(yearPrefix + dateString.substring(5, 7));

        return DateTime(year, monthIndex, day);
      }
    } else {
      return null;
    }
  }

  static TransactionMedium getTransactionMedium(String message) {
    if (message.toLowerCase().contains('upi')) {
      return TransactionMedium.upi;
    } else if (message.toLowerCase().contains('netbanking')) {
      return TransactionMedium.netbanking;
    } else if (message.toLowerCase().contains('debit card')) {
      return TransactionMedium.debitCard;
    } else if (message.toLowerCase().contains('credit card')) {
      return TransactionMedium.creditCard;
    } else if (message.toLowerCase().contains('wallet')) {
      return TransactionMedium.wallet;
    } else if (message.toLowerCase().contains('imps')) {
      return TransactionMedium.imps;
    } else if (message.toLowerCase().contains('neft')) {
      return TransactionMedium.imps;
    } else if (message.toLowerCase().contains('rtgs')) {
      return TransactionMedium.imps;
    } else {
      return TransactionMedium.unknown;
    }
  }

  static SMSTransactionData? getTransactionData(
    String message,
    DateTime smsDate,
    int id,
  ) {
    TransactionType? transactionType = getTransactionType(message);
    String? referenceNumber = getReferenceNumber(message);
    double? amount = getAmount(message);
    String? accountNo = getAccountNo(message);
    String? bankName = getBankName(message);
    DateTime? expenseDate = getDate(message);
    TransactionMedium transactionMedium = getTransactionMedium(message);

    if ((transactionType == null) ||
        (amount == null) ||
        (referenceNumber == null) ||
        (expenseDate == null)) {
      logger.i('Not a valid transaction message. \nMessage : $message');
      return null;
    }

    return SMSTransactionData(
      id: id,
      transactionType: transactionType,
      referenceNumber: referenceNumber,
      amount: amount,
      date: expenseDate,
      associatedAccountNumber: accountNo,
      associatedBankName: bankName,
      medium: transactionMedium,
      smsBody: message,
      smsDate: smsDate,
    );
  }
}
