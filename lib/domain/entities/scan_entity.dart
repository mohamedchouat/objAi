import '../../data/models/scan_model.dart';

/// The core domain entity representing a single successful scan.
/// This is independent of any data source (e.g., Hive or API).
class ScanEntity {
  final int id;
  final String objectName;
  final String description;
  final String originalImagePath;
  final String wikiImageUrl;
  final DateTime date;

  const ScanEntity({
    required this.id,
    required this.objectName,
    required this.description,
    required this.originalImagePath,
    required this.wikiImageUrl,
    required this.date,
  });

  /// Factory method to create a ScanEntity from a ScanModel (Data Layer).
  static ScanEntity fromModel(ScanModel m) => ScanEntity(
    id: m.id,
    objectName: m.objectName,
    description: m.description,
    originalImagePath: m.originalImagePath,
    wikiImageUrl: m.wikiImageUrl,
    date: m.date,
  );
}