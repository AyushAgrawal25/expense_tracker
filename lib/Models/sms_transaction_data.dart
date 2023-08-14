import 'package:expense_tracker/Models/transaction_data.dart';

enum SMSTransactionMedium { upi, bankTransfer, other }

class SMSTransactionData extends TransactionData {
  final SMSTransactionMedium medium;
  final DateTime smsDate;
  final String smsBody;

  SMSTransactionData({
    required this.medium,
    required this.smsDate,
    required this.smsBody,
    required int id,
    required String referenceNumber,
    required TransactionType transactionType,
    required double amount,
    required DateTime date,
    String? receiver,
    String? sender,
    String? associatedBankName,
    String? associatedAccountNumber,
  }) : super(
          id: id,
          referenceNumber: referenceNumber,
          transactionType: transactionType,
          amount: amount,
          date: date,
          receiver: receiver,
          sender: sender,
          associatedBankName: associatedBankName,
          associatedAccountNumber: associatedAccountNumber,
        );

  factory SMSTransactionData.fromJson(Map<String, dynamic> json) {
    return SMSTransactionData(
      medium: json['medium'] == 'upi'
          ? SMSTransactionMedium.upi
          : json['medium'] == 'bankTransfer'
              ? SMSTransactionMedium.bankTransfer
              : SMSTransactionMedium.other,
      smsDate: DateTime.parse(json['smsDate']),
      smsBody: json['smsBody'],
      id: json['id'],
      referenceNumber: json['reference_number'],
      transactionType: json['transaction_type'] == 'credit'
          ? TransactionType.credit
          : TransactionType.debit,
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      receiver: json['receiver_name'],
      sender: json['sender_name'],
      associatedBankName: json['associated_bank_name'],
      associatedAccountNumber: json['associated_account_number'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'medium': medium == SMSTransactionMedium.upi
          ? 'upi'
          : medium == SMSTransactionMedium.bankTransfer
              ? 'bankTransfer'
              : 'other',
      'smsDate': smsDate.toIso8601String(),
      'smsBody': smsBody,
      'id': id,
      'reference_number': referenceNumber,
      'transaction_type':
          transactionType == TransactionType.credit ? 'credit' : 'debit',
      'amount': amount,
      'date': date.toIso8601String(),
      'receiver_name': receiver,
      'sender_name': sender,
      'associated_bank_name': associatedBankName,
      'associated_account_number': associatedAccountNumber,
    };
  }
}
