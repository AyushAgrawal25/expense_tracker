enum TransactionType {
  credit('credit', 'Credit'),
  debit('debit', 'Debit');

  const TransactionType(this.value, this.name);

  final String value;
  final String name;
}

class TransactionData {
  final int id;
  final String referenceNumber;
  final TransactionType transactionType;
  final double amount;
  final DateTime date;
  final String? associatedBankName;
  final String? associatedAccountNumber;
  final String? receiver;
  final String? sender;

  TransactionData({
    required this.id,
    required this.referenceNumber,
    required this.transactionType,
    required this.amount,
    required this.date,
    this.associatedBankName,
    this.associatedAccountNumber,
    this.receiver,
    this.sender,
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      id: json['id'],
      referenceNumber: json['reference_number'],
      transactionType: json['transaction_type'] == 'credit'
          ? TransactionType.credit
          : TransactionType.debit,
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      associatedBankName: json['associated_bank_name'],
      associatedAccountNumber: json['associated_account_number'],
      receiver: json['receiver_name'],
      sender: json['sender_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reference_number': referenceNumber,
      'transaction_type':
          transactionType == TransactionType.credit ? 'credit' : 'debit',
      'amount': amount,
      'date': date.toIso8601String(),
      'associated_bank_name': associatedBankName,
      'associated_account_number': associatedAccountNumber,
      'receiver_name': receiver,
      'sender_name': sender,
    };
  }
}
