import 'dart:io';

import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class SMSUtils {
  static Future<List<SmsMessage>> getSMS() async {
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

class FileUtils {
  static Future<String> createExternalFile(String fileName) async {
    const externalDirPermission = Permission.storage;
    final permissionStatus = await externalDirPermission.request();
    if (permissionStatus.isGranted) {
      final externalDir = await getExternalStorageDirectory();
      final filePath = '${externalDir!.path}/$fileName';
      return filePath;
    } else {
      throw Exception('Permission not granted');
    }
  }

  static Future<bool> writeInFile(String filePath, String data) async {
    const externalDirPermission = Permission.storage;
    final permissionStatus = await externalDirPermission.request();
    if (permissionStatus.isGranted) {
      final file = await File(filePath);
      await file.writeAsString(data);
      return true;
    } else {
      throw Exception('Permission not granted');
    }
  }
}
