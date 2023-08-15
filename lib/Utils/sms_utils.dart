import 'package:expense_tracker/Utils/logger_utils.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';

class SMSUtils {
  static Future<List<SmsMessage>> getSMS() async {
    PermissionStatus status = await Permission.sms.request();
    if (status.isDenied) {
      logger.e('sms permission denied.');
      return [];
    }

    final SmsQuery query = SmsQuery();
    final messages = await query.querySms(
      kinds: [
        SmsQueryKind.inbox,
      ],
    );
    logger.i('sms inbox messages: ${messages.length}');
    return messages;
  }

  static Future<void> saveSMSInJSON() async {
    final messages = await getSMS();
    logger.i('saving sms inbox messages: ${messages.length}');
  }
}
