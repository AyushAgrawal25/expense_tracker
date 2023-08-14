import 'package:expense_tracker/Models/sms_transaction_data.dart';
import 'package:expense_tracker/Models/transaction_data.dart';

class ExpenseData {
  final int id;
  final String? title;
  final String? description;
  final double totalAmount;
  final double effectiveAmount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final TransactionType transactionType;
  final String? receiver;
  final String? sender;
  final SMSTransactionData? smsTransaction;

  ExpenseData({
    required this.id,
    this.title,
    this.description,
    required this.totalAmount,
    required this.effectiveAmount,
    required this.createdAt,
    required this.updatedAt,
    required this.transactionType,
    this.receiver,
    this.sender,
    this.smsTransaction,
  });

  factory ExpenseData.fromJson(Map<String, dynamic> json) {
    return ExpenseData(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      totalAmount: json['total_amount'],
      effectiveAmount: json['effective_amount'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      transactionType: TransactionType.values[json['transaction_type']],
      receiver: json['receiver'],
      sender: json['sender'],
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
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'transaction_type': transactionType.index,
      'receiver': receiver,
      'sender': sender,
      'sms_transaction': smsTransaction?.toJson(),
    };
  }
}
