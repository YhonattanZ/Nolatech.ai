import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class CustomHttpProvider {
  final String baseUrl;

  CustomHttpProvider({required this.baseUrl});

  Future<http.Response> get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));
    _logStatusCode(response);
    return response;
  }

  Future<http.Response> post(String endpoint,
      {Map<String, dynamic>? body}) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );
    _logStatusCode(response);
    return response;
  }

  Future<http.Response> put(String endpoint,
      {Map<String, dynamic>? body}) async {
    final response = await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );
    _logStatusCode(response);
    return response;
  }

  Future<http.Response> delete(String endpoint) async {
    final response = await http.delete(Uri.parse('$baseUrl$endpoint'));
    _logStatusCode(response);
    return response;
  }

  void _logStatusCode(http.Response response) {
    if (response.statusCode == 200) {
      log('Request to ${response.request?.url} was successful with status code: ${response.statusCode}');
    } else {
      log('Request to ${response.request?.url} failed with status code: ${response.statusCode}');
    }
  }
}
