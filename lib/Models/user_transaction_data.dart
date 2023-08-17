import 'package:expense_tracker/Models/transaction_data.dart';

enum UserTransactionMedium { cash, bank, upi, card }

class UserTransactionData extends TransactionData {
  final UserTransactionMedium medium;

  UserTransactionData({
    required this.medium,
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

  factory UserTransactionData.fromJson(Map<String, dynamic> json) {
    return UserTransactionData(
      medium: getUserTransactionMediumFromString(json['medium']),
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
      'medium': getStringFromUserTransactionMedium(medium),
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

  String get formattedMedium {
    switch (medium) {
      case UserTransactionMedium.cash:
        return 'Cash';
      case UserTransactionMedium.bank:
        return 'Bank';
      case UserTransactionMedium.upi:
        return 'UPI';
      case UserTransactionMedium.card:
        return 'Card';
      default:
        return 'Unknown';
    }
  }

  static UserTransactionMedium getUserTransactionMediumFromString(
      String medium) {
    switch (medium) {
      case 'cash':
        return UserTransactionMedium.cash;
      case 'bank':
        return UserTransactionMedium.bank;
      case 'upi':
        return UserTransactionMedium.upi;
      case 'card':
        return UserTransactionMedium.card;
      default:
        return UserTransactionMedium.cash;
    }
  }

  static String getStringFromUserTransactionMedium(
      UserTransactionMedium medium) {
    switch (medium) {
      case UserTransactionMedium.cash:
        return 'cash';
      case UserTransactionMedium.bank:
        return 'bank';
      case UserTransactionMedium.upi:
        return 'upi';
      case UserTransactionMedium.card:
        return 'card';
      default:
        return 'cash';
    }
  }
}
