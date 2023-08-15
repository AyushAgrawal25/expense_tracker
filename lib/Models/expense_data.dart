import 'package:expense_tracker/Models/sms_transaction_data.dart';
import 'package:expense_tracker/Models/transaction_data.dart';
import 'package:flutter/material.dart';

class ExpenseData {
  final int id;
  final String? title;
  final String? description;
  final double totalAmount;
  final double effectiveAmount;
  final DateTime expenseDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final TransactionType transactionType;
  final String? spentOn;
  final SMSTransactionData? smsTransaction;

  ExpenseData({
    required this.id,
    this.title,
    this.description,
    required this.totalAmount,
    required this.effectiveAmount,
    required this.expenseDate,
    required this.createdAt,
    required this.updatedAt,
    required this.transactionType,
    this.spentOn,
    this.smsTransaction,
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
      smsTransaction: json['sms_transaction'] != null
          ? SMSTransactionData.fromJson(json['sms_transaction'])
          : null,
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
      'sms_transaction': smsTransaction?.toJson(),
    };
  }
}

List<ExpenseData> sampleExpenses = [
  ExpenseData(
    id: 1,
    title: 'Gift',
    description: 'Gift for friend',
    totalAmount: 1000,
    effectiveAmount: 1000,
    expenseDate: DateTime.now(),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    transactionType: TransactionType.debit,
    spentOn: 'Aman\'s Girlfriend',
    smsTransaction: sampleSMSTransactions[0],
  ),
  ExpenseData(
    id: 2,
    title: 'Grocerry',
    description: 'Grocerry for home',
    totalAmount: 10000,
    effectiveAmount: 10000,
    expenseDate: DateTime.now(),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    transactionType: TransactionType.credit,
    spentOn: 'Big Bazar',
    smsTransaction: sampleSMSTransactions[1],
  ),
];