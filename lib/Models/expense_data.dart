import 'package:expense_tracker/Models/sms_transaction_data.dart';
import 'package:expense_tracker/Models/transaction_data.dart';
import 'package:expense_tracker/Models/user_transaction_data.dart';

class ExpenseData {
  final int id;
  final String title;
  final String? description;
  final double totalAmount;
  final double effectiveAmount;
  final DateTime expenseDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final TransactionType transactionType;
  final String? spentOn;
  final TransactionData? transaction;

  ExpenseData({
    required this.id,
    required this.title,
    this.description,
    required this.totalAmount,
    required this.effectiveAmount,
    required this.expenseDate,
    required this.createdAt,
    required this.updatedAt,
    required this.transactionType,
    this.spentOn,
    this.transaction,
  });

  factory ExpenseData.fromJson(Map<String, dynamic> json) {
    return ExpenseData(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      totalAmount: json['total_amount'],
      effectiveAmount: json['effective_amount'],
      expenseDate: DateTime.parse(json['expense_date']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      transactionType: TransactionType.values[json['transaction_type']],
      spentOn: json['spent_on'],
      transaction: json['transaction'] != null
          ? TransactionData.fromJson(json['transaction'])
          : null,
    );
  }

  factory ExpenseData.fromTransaction(
      int expenseId, TransactionData transactionData) {
    String title = 'Transaction';
    return ExpenseData(
      id: expenseId,
      title: title,
      totalAmount: transactionData.amount,
      effectiveAmount: transactionData.amount,
      expenseDate: transactionData.date,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      transactionType: transactionData.transactionType,
      transaction: transactionData,
      spentOn: transactionData.receiver,
    );
  }

  factory ExpenseData.fromSMSTransaction(
      int expenseId, SMSTransactionData smsTransactionData) {
    String title = '${smsTransactionData.formattedMedium} Transaction';
    return ExpenseData(
      id: expenseId,
      title: title,
      totalAmount: smsTransactionData.amount,
      effectiveAmount: smsTransactionData.amount,
      expenseDate: smsTransactionData.date,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      transactionType: smsTransactionData.transactionType,
      transaction: smsTransactionData,
      spentOn: smsTransactionData.receiver,
    );
  }

  factory ExpenseData.fromUserTransaction(
      int expenseId, UserTransactionData userTransactionData) {
    String title = '${userTransactionData.formattedMedium} Transaction';
    return ExpenseData(
      id: expenseId,
      title: title,
      totalAmount: userTransactionData.amount,
      effectiveAmount: userTransactionData.amount,
      expenseDate: userTransactionData.date,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      transactionType: userTransactionData.transactionType,
      transaction: userTransactionData,
      spentOn: userTransactionData.receiver,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'total_amount': totalAmount,
      'effective_amount': effectiveAmount,
      'expense_date': expenseDate.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'transaction_type': transactionType.index,
      'spent_on': spentOn,
      'sms_transaction': transaction?.toJson(),
    };
  }
}

List<ExpenseData> sampleExpenses = [
  ExpenseData(
    id: 1,
    title: 'Gift',
    description: 'Gift for friend',
    totalAmount: 100,
    effectiveAmount: 100,
    expenseDate: DateTime.now(),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    transactionType: TransactionType.debit,
    spentOn: 'Aman\'s Girlfriend',
    transaction: sampleSMSTransactions[0],
  ),
  ExpenseData(
    id: 2,
    title: 'Grocery',
    description: 'Grocery for home',
    totalAmount: 25,
    effectiveAmount: 25,
    expenseDate: DateTime.now(),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    transactionType: TransactionType.credit,
    spentOn: 'Big Bazar',
    transaction: sampleSMSTransactions[1],
  ),
];
