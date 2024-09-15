
import 'package:dio/dio.dart';

class ApiRequest {
  final String url;
  final Map<String, dynamic>? data;

  ApiRequest({required this.url, required this.data});

  Dio _dio() {
    return Dio(BaseOptions(headers: {'Authorization': 'B....'}));
  }

  Future<void> get({
    required Function(List<dynamic> result) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    await _dio().get(url, queryParameters: data).then((res) {
      onSuccess(res.data);
    }).catchError((err) {
      onError(err);
    });
  }
}