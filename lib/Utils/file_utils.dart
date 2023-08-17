import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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
      final file = File(filePath);
      await file.writeAsString(data);
      return true;
    } else {
      throw Exception('Permission not granted');
    }
  }
}
