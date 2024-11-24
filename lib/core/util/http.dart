import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final apiClient = ApiClient(http.Client());
class ApiClient {
  final http.Client client;

  ApiClient(this.client);

  Future<String> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token') ?? ''; // Return an empty string if no token is found
  }

  Future<Map<String, String>> _getHeaders() async {
   String token = await getAuthToken();
    return {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
    };
  }

  Future<http.Response> get(String url) async {
    final headers = await _getHeaders();
    return client.get(Uri.parse(url), headers: headers);
  }

  Future<http.Response> put(String url, {required dynamic body}) async {
    final headers = await _getHeaders();
    return client.put(
      Uri.parse(url),
      headers: headers,
      body: body,
    );
  }

  Future<http.Response> post(String url, {required dynamic body}) async {
    final headers = await _getHeaders();
    return client.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );
  }
}