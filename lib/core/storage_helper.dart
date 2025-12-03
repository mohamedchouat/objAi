import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class StorageHelper {
  static Future<String> saveImageFile(File imageFile) async {
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/scan_${Uuid().v4()}.jpg';
    final saved = await imageFile.copy(path);
    return saved.path;
  }
}