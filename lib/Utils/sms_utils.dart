import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';

class SMSUtils {
  static Future<List<SmsMessage>> getSMS() async {
    PermissionStatus status = await Permission.sms.request();
    if (status.isDenied) {
      // TODO: add a logger for denied status.
      return [];
    }

    final SmsQuery query = SmsQuery();
    final messages = await query.querySms(
      kinds: [
        SmsQueryKind.inbox,
      ],
    );
    print('sms inbox messages: ${messages.length}');
    return messages;
  }

  static Future<void> saveSMSInJSON() async {
    final messages = await getSMS();
    print('saving sms inbox messages: ${messages.length}');
  }
}
