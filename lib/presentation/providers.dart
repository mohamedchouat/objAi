import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../data/datasources/local_datasource.dart';
import '../data/datasources/vision_datasource.dart';
import '../data/datasources/wiki_datasource.dart';
import '../data/repositories/scan_repository_impl.dart';
import '../domain/entities/scan_entity.dart';

final dioProvider = Provider<Dio>((ref) => Dio());
final clarifaiApiKeyProvider = Provider<String>((ref) => '03724847cdfc49d887aa7e7b139417b7');

final visionProvider = Provider<VisionDataSource>((ref) {
  return VisionDataSource(ref.read(dioProvider), apiKey: ref.read(clarifaiApiKeyProvider));
});

final wikiProvider = Provider<WikiDataSource>((ref) => WikiDataSource(ref.read(dioProvider)));
final localProvider = Provider<LocalDataSource>((ref) => LocalDataSource());

final scanRepositoryProvider = Provider<ScanRepositoryImpl>((ref) {
  return ScanRepositoryImpl(
    vision: ref.read(visionProvider),
    wiki: ref.read(wikiProvider),
    local: ref.read(localProvider),
  );
});

final historyProvider = StateNotifierProvider<HistoryNotifier, List<ScanEntity>>((ref) {
  final repo = ref.read(scanRepositoryProvider);
  return HistoryNotifier(repo);
});

class HistoryNotifier extends StateNotifier<List<ScanEntity>> {
  final ScanRepositoryImpl repo;
  HistoryNotifier(this.repo) : super([]);

  void load() => state = repo.getHistory();

  Future<ScanEntity> detectAndSave(File imageFile) async {
    final result = await repo.detectAndSave(imageFile);
    load();
    return result;
  }

  Future<void> delete(int id) async {
    await repo.local.deleteScan(id);
    load();
  }
}
