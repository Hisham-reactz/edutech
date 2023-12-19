import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl;
  final String _apiKey;

  ApiService(this._baseUrl, this._apiKey);

  Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$endpoint?api_key=$_apiKey'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch data from the API');
    }
  }

  Future<Map<String, dynamic>> post(
      String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint?api_key=$_apiKey'),
      body: json.encode(body),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to post data to the API');
    }
  }

  Future<Map<String, dynamic>> patch(
      String endpoint, Map<String, dynamic> body) async {
    final response = await http.patch(
      Uri.parse('$_baseUrl/$endpoint?api_key=$_apiKey'),
      body: json.encode(body),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to patch data to the API');
    }
  }

  Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/$endpoint?api_key=$_apiKey'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to delete data from the API');
    }
  }
}
