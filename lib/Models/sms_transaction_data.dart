import 'package:expense_tracker/Models/transaction_data.dart';

enum SMSTransactionMedium {
  upi,
  netbanking,
  debitCard,
  creditCard,
  wallet,
  imps,
  neft,
  rtgs,
  unknown
}

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
      smsDate: DateTime.parse(json['smsDate']),
      smsBody: json['smsBody'],
      id: json['id'],
      medium: getTransactionMediumFromString(json['medium']),
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
      'medium': getTransactionMediumAsString(medium),
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

  String get formattedMedium {
    String formattedMedium = '';
    switch (medium) {
      case SMSTransactionMedium.upi:
        formattedMedium = 'UPI';
        break;
      case SMSTransactionMedium.netbanking:
        formattedMedium = 'Net Banking';
        break;
      case SMSTransactionMedium.debitCard:
        formattedMedium = 'Debit Card';
        break;
      case SMSTransactionMedium.creditCard:
        formattedMedium = 'Credit Card';
        break;
      case SMSTransactionMedium.wallet:
        formattedMedium = 'Wallet';
        break;
      case SMSTransactionMedium.imps:
        formattedMedium = 'IMPS';
        break;
      case SMSTransactionMedium.neft:
        formattedMedium = 'NEFT';
        break;
      case SMSTransactionMedium.rtgs:
        formattedMedium = 'RTGS';
        break;
      default:
        formattedMedium = 'Unknown';
    }
    return formattedMedium;
  }

  static SMSTransactionMedium getTransactionMediumFromString(
      String mediumString) {
    SMSTransactionMedium medium = SMSTransactionMedium.unknown;
    switch (mediumString) {
      case 'upi':
        medium = SMSTransactionMedium.upi;
        break;
      case 'netbanking':
        medium = SMSTransactionMedium.netbanking;
        break;
      case 'debitCard':
        medium = SMSTransactionMedium.debitCard;
        break;
      case 'creditCard':
        medium = SMSTransactionMedium.creditCard;
        break;
      case 'wallet':
        medium = SMSTransactionMedium.wallet;
        break;
      case 'imps':
        medium = SMSTransactionMedium.imps;
        break;
      case 'neft':
        medium = SMSTransactionMedium.neft;
        break;
      case 'rtgs':
        medium = SMSTransactionMedium.rtgs;
        break;
      default:
        medium = SMSTransactionMedium.unknown;
    }
    return medium;
  }

  static String getTransactionMediumAsString(SMSTransactionMedium medium) {
    String mediumString = '';
    switch (medium) {
      case SMSTransactionMedium.upi:
        mediumString = 'upi';
        break;
      case SMSTransactionMedium.netbanking:
        mediumString = 'netbanking';
        break;
      case SMSTransactionMedium.debitCard:
        mediumString = 'debitCard';
        break;
      case SMSTransactionMedium.creditCard:
        mediumString = 'creditCard';
        break;
      case SMSTransactionMedium.wallet:
        mediumString = 'wallet';
        break;
      case SMSTransactionMedium.imps:
        mediumString = 'imps';
        break;
      case SMSTransactionMedium.neft:
        mediumString = 'neft';
        break;
      case SMSTransactionMedium.rtgs:
        mediumString = 'rtgs';
        break;
      default:
        mediumString = 'unknown';
    }
    return mediumString;
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
    medium: SMSTransactionMedium.neft,
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

List<String> sampleUPIMessages = [
  "Dear UPI user A/C X0077 credited by 200.0 on date 10Aug23 trf to KAVALRY TECHNOLO Ref no 322249124744. If not u? call 1800111109. -SBI",
  "Dear UPI user A/C X0077 debited by 200.0 on date 10Aug23 trf to KAVALRY TECHNOLO Refno 322249124744. If not u? call 1800111109. -SBI",
  "Dear SBI UPI User, your account is debited INR 500.0 on Date 2019-08-23 09:19:37 PM by UPI Ref No 923521526104.Download YONO @ www.yonosbi.com",
  "Dear SBI UPI User, your account is debited INR 500.0 on Date 06Sep19 by UPI Ref No 924919593161",
  "Dear SBI UPI User, your account is debited INR 500.0 on Date 06Sep19 by UPI Ref No 924919593161",
  "Dear SBI UPI User, your account is debited INR 500.0 on Date 2019-08-23 09:19:37 PM by UPI Ref No 923521526104.Download YONO @ www.yonosbi.com",
  "Rs299.0 debited@SBI UPI frm A/cX0077 on 11Sep20 RefNo 025521052625. If not done by u, fwd this SMS to 9223008333/Call 1800111109 or 09449112211 to block UPI",
  "Rs158.0 debited@SBI UPI frm A/cX0077 on 27Oct21 RefNo 130093108167. If not done by u, fwd this SMS to 9223008333/Call 1800111109 or 09449112211 to block UPI",
  "Rs300.0 debited¡SBI UPI frm A/cX0077 on 04Sep22 RefNo 224768560473. If not done by u, fwd this SMS to 9223008333/Call 1800111109 or 09449112211 to block UPI",
  "Rs15.0 debited@SBI UPI frm A/cX0077 on 08Jan23 RefNo 300845077324. If not done by u, fwd this SMS to 9223008333/Call 1800111109 or 09449112211 to block UPI",
  "Rs829.0 debited!SBI UPI frm A/cX0077 on 01Apr22 RefNo 209123723983. If not done by u, fwd this SMS to 9223008333/Call 1800111109 or 09449112211 to block UPI"
];
