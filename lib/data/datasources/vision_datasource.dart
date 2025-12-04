import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

class VisionApiException implements Exception {
  final String message;
  VisionApiException(this.message);
  @override
  String toString() => 'VisionApiException: $message';
}

class VisionDataSource {
  final Dio dio;
  final String apiKey;
  VisionDataSource(this.dio, {required this.apiKey});

  Future<String> detectObject(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final base64Image = base64Encode(bytes);

    final payload = {
      "inputs": [
        {
          "data": {"image": {"base64": base64Image}}
        }
      ],
      "model": {
        "output_info": {
          "output_config": {
            "language": "en"
          }
        }
      }
    };

    try {
      final res = await dio.post(
        'https://api.clarifai.com/v2/users/clarifai/apps/main/models/general-image-recognition/versions/aa7f35c01e0642fda5cf400f543e7c40/outputs',
        data: payload,
        options: Options(headers: {
          'Authorization': 'Key $apiKey',
          'Content-Type': 'application/json',
        }),
      );

      if (res.statusCode != 200) {
        throw VisionApiException('API call failed with status code ${res.statusCode}: ${res.statusMessage}');
      }

      final status = res.data['status'];
      if (status == null || status['code'] != 10000) {
        throw VisionApiException('Clarifai API Error: ${status?['description'] ?? 'Unknown status error'}');
      }

      final outputs = res.data['outputs'] as List<dynamic>?;
      if (outputs == null || outputs.isEmpty) {
        throw VisionApiException('API response is missing the "outputs" array.');
      }
      
      final concepts = outputs[0]['data']?['concepts'] as List<dynamic>?;
      if (concepts == null || concepts.isEmpty) {
        throw VisionApiException('No concepts found in the API response.');
      }
      
      return concepts[0]['name'];

    } on DioException catch (e) {
      String errorMessage = 'Network error during object detection.';
      if (e.response != null) {
        errorMessage += ' Received status: ${e.response!.statusCode}. Response: ${e.response!.data}';
      } else {
        errorMessage += ' Dio error type: ${e.type}.';
      }
      throw Exception(errorMessage);
    } catch (e) {
      rethrow;
    }
  }
}