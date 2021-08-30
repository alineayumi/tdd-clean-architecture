import 'package:tdd_clean_architecture/core/http_client/http_client.dart';
import 'package:dio/dio.dart';

class DioImplementation implements HttpClient {
  final client = Dio();

  @override
  Future<HttpResponse> get(String url) async {
    final response = await client.get(url);
    return HttpResponse(data: response.data, statusCode: response.statusCode);
  }

  @override
  Future<HttpResponse> post(String url, {required Map<String, dynamic> body}) {
    // TODO: implement post
    throw UnimplementedError();
  }
}
