import 'package:dio/dio.dart';

class WikiResult {
  final String title;
  final String extract;
  final String imageUrl;

  WikiResult({required this.title, required this.extract, required this.imageUrl});
}

class WikiDataSource {
  final Dio dio;
  WikiDataSource(this.dio);

  Future<WikiResult> fetchSummary(String query) async {
    final url = 'https://en.wikipedia.org/api/rest_v1/page/summary/${Uri.encodeComponent(query)}';
    final res = await dio.get(url);

    return WikiResult(
      title: res.data['title'] ?? query,
      extract: res.data['extract'] ?? '',
      imageUrl: res.data['thumbnail']?['source'] ?? '',
    );
  }
}
