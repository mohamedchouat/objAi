import 'dart:io';
import '../datasources/local_datasource.dart';
import '../datasources/vision_datasource.dart';
import '../datasources/wiki_datasource.dart';
import '../models/scan_model.dart';
import '../../core/storage_helper.dart';
import '../../domain/entities/scan_entity.dart';

class ScanRepositoryImpl {
  final VisionDataSource vision;
  final WikiDataSource wiki;
  final LocalDataSource local;

  ScanRepositoryImpl({required this.vision, required this.wiki, required this.local});

  Future<ScanEntity> detectAndSave(File imageFile) async {
    final objectName = await vision.detectObject(imageFile);
    final wikiData = await wiki.fetchSummary(objectName);
    final localPath = await StorageHelper.saveImageFile(imageFile);

    final model = ScanModel(
      id: DateTime.now().millisecondsSinceEpoch,
      objectName: wikiData.title,
      description: wikiData.extract,
      originalImagePath: localPath,
      wikiImageUrl: wikiData.imageUrl,
      date: DateTime.now(),
    );
    
    await local.saveScan(model);

    return ScanEntity.fromModel(model);
  }

  List<ScanEntity> getHistory() =>
      local.getAllScans().map((m) => ScanEntity.fromModel(m)).toList();
}