import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthRemoteDataSource {
  Future<bool> signIn(String username, String password);
  Future<bool> signUp(Map<String, dynamic> userDetails);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final Logger logger = Logger();

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<bool> signIn(String username, String password) async {
    try {
      // Log the request payload
      final payload = jsonEncode({
        'username': username,
        'password': password,
      });
      logger.i('Sending signIn request with payload: $payload');

      final response = await client.post(
        Uri.parse('https://fakestoreapi.com/auth/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: payload,
      );

      // Logging the actual API response
      logger.i('Response Body: ${response.body}');
      logger.i('Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        ///////////store token/////////////////////
        final token = jsonResponse['token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        prefs.getString('auth_token');

        if (token != null) {
          logger.i('Login successful. Token: $token');
          // return true;
        } else {
          logger.w('Login failed: Token is null');
          // return false; // Login failed
        }
      } else if (response.statusCode == 400) {
        logger.w('Invalid credentials. Status Code: 400');
        //return false; // Login failed
      } else {
        logger.e('Unexpected error: ${response.statusCode}');
        //  return false; // Handle other error statuses
      }
    } catch (e) {
      logger.e('API error: $e');
      // return false; // Return false if something goes wrong
    }
    return true;
  }

  @override
  Future<bool> signUp(Map<String, dynamic> userDetails) async {
    try {
      final response = await client.post(
        Uri.parse('https://fakestoreapi.com/users'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userDetails),
      );

      if (response.statusCode == 200) {
        logger.i('Sign-up successful: ${response.body}');
        return true;
      } else {
        logger.e('Sign-up failed: ${response.statusCode}');
        return false; // Handle other error statuses
      }
    } catch (e) {
      logger.e('API error during sign-up: $e');
      return false; // Return false if something goes wrong
    }
  }
}
