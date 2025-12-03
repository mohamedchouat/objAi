import 'package:hive/hive.dart';
import '../models/scan_model.dart';

class LocalDataSource {
  static const boxName = 'scans_box';

  Future<void> saveScan(ScanModel scan) async {
    final box = Hive.box<ScanModel>(boxName);
    await box.add(scan);
  }

  List<ScanModel> getAllScans() {
    final box = Hive.box<ScanModel>(boxName);
    final list = box.values.toList();
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  Future<void> deleteScan(int id) async {
    final box = Hive.box<ScanModel>(boxName);
    final key = box.keys.firstWhere(
      (k) => box.get(k)?.id == id,
      orElse: () => null,
    );
    if (key != null) {
      await box.delete(key);
    }
  }
}
