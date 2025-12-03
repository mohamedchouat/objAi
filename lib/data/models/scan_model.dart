import 'package:hive/hive.dart';
part 'scan_model.g.dart';

@HiveType(typeId: 0)
class ScanModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String objectName;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String originalImagePath;

  @HiveField(4)
  final String wikiImageUrl;

  @HiveField(5)
  final DateTime date;

  ScanModel({
    required this.id,
    required this.objectName,
    required this.description,
    required this.originalImagePath,
    required this.wikiImageUrl,
    required this.date,
  });
}
