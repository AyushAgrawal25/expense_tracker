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

List<SMSTransactionData> sampleSMSTransactions = [
  SMSTransactionData(
    medium: SMSTransactionMedium.upi,
    smsDate: DateTime.now(),
    smsBody:
        'Dear UPI user, Rs.1000.00 has been debited from your account 123456789012 via UPI Ref No 354123456789012. If not done by you, forward this SMS from mobile number registered with your bank to 9223008333 to block your account.',
    id: 1,
    referenceNumber: '354123456789012',
    transactionType: TransactionType.debit,
    amount: 1000,
    date: DateTime.now(),
    receiver: 'Aman\'s Girlfriend',
    sender: 'Aman Singh',
    associatedBankName: 'HDFC Bank',
    associatedAccountNumber: '123456789012',
  ),
  SMSTransactionData(
    medium: SMSTransactionMedium.bankTransfer,
    smsDate: DateTime.now(),
    smsBody:
        'Dear Customer, Rs.1000.00 has been credited to your account 123456724224 on 01/01/2021 12:00:00 via IMPS Ref No 354123245557442. If not done by you, forward this SMS from mobile number registered with your bank to 9223008333 to block your account.',
    id: 2,
    referenceNumber: '354123245557442',
    transactionType: TransactionType.credit,
    amount: 1000,
    date: DateTime.now(),
    receiver: 'Big Bazar',
    sender: 'Jane Doe',
    associatedBankName: 'HDFC Bank',
    associatedAccountNumber: '123456724224',
  ),
];
