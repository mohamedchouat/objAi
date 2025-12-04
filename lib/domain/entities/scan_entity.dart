import '../../data/models/scan_model.dart';

class ScanEntity {
  final int id;
  final String objectName;
  final String description;
  final String originalImagePath;
  final String? wikiImageUrl;
  final DateTime date;

  ScanEntity({
    required this.id,
    required this.objectName,
    required this.description,
    required this.originalImagePath,
    this.wikiImageUrl,
    required this.date,
  });

  factory ScanEntity.fromModel(ScanModel model) {
    return ScanEntity(
      id: model.id,
      objectName: model.objectName,
      description: model.description,
      originalImagePath: model.originalImagePath,
      wikiImageUrl: model.wikiImageUrl,
      date: model.date,
    );
  }
}