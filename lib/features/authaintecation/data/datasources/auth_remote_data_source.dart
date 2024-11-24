import 'dart:convert';
import 'package:flutter_stylish/core/util/logger.dart';
import 'package:flutter_stylish/core/util/http.dart';
import 'package:flutter_stylish/core/util/api.dart';

import '../../domain/entities/user_request_entity.dart';

// TODO CODE-REVIEW the code review that added must applying on whole file
abstract class AuthRemoteDataSource {
  /**
   * TODO CODE-REVIEW use request entity instead of ordered params
   * for ex : signIn({required SignInRequestEntity entity})
   */
  
  //Done

  Future<String?> signIn({required UserRequestEntity entity});

  Future<bool> signUp(Map<String, dynamic> userDetails);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  /**
   * TODO CODE-REVIEW the client instance of http.Client class in your project is repeated in each data source file
   * for best practice define in separate file as const variable and used it when you want
   */

  //Done

  /**
   * TODO CODE-REVIEW the logger instance of Logger class in your project is repeated in each file
   * for best practice define in separate file as const variable and used it when you want
   */

  //Done

  /* Future<bool> signIn(String username, String password) async {
    try {
      // Log the request payload
      final payload = jsonEncode({
        'username': username,
        'password': password,
      });
      logger.i('Sending signIn request with payload: $payload');

      /**
       * TODO CODE-REVIEW when you use request entity the entity must contained toJson method
       * for better practice use toJson method instead of payload
       */
      
      //Done

      /**
       * TODO CODE-REVIEW the api url endpoint should be in separate file as a const variable
       * and use that variable instead of ,for best practice
       */

       //Done

      /**
       * TODO CODE-REVIEW the headers map structure is better to define in way not to repeat in each api request
       */
      
      //Done

      final response = await client.post(
        Uri.parse(signIN),
        headers: {
          'Content-Type': 'application/json',
        },
        body: payload,
      );

      // Logging the actual API response
      logger.i('Response Body: ${response.body}');
      logger.i('Status Code: ${response.statusCode}');

      /**
       * TODO CODE-REVIEW the api logic should be applied in business logic layer so in BLoC or Cubit structure
       */

      //Done

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
  }*/

  Future<String?> signIn({required UserRequestEntity entity}) async {
    try {
      // Log the request payload using the `toJson` method of UserRequestEntity
      final payload = jsonEncode(entity.toJson());
      logger.i('Sending signIn request with payload: $payload');

      // Make the POST request using the ApiClient with the prepared payload
      final response = await apiClient.post(
        signIN,
        body: jsonEncode(entity),
      );

      // Log the actual API response
      logger.i('Response Body: ${response.body}');
      logger.i('Status Code: ${response.statusCode}');

      // Check for success response and extract token if present
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final token = jsonResponse['token'];
        
        if (token != null) {
          logger.i('Login successful. Token received: $token');
          return token; // Return the token if login was successful
        } else {
          logger.w('Login failed: Token is null');
          return null; // Null token indicates login failure
        }
      } else if (response.statusCode == 400) {
        logger.w('Invalid credentials. Status Code: 400');
        return null; // Invalid credentials
      } else {
        logger.e('Unexpected error: ${response.statusCode}');
        return null; // Unexpected error
      }
    } catch (e) {
      logger.e('API error: $e');
      return null; // Return null if an error occurs
    }
  }

  //@override
  Future<bool> signUp(Map<String, dynamic> userDetails) async {
    try {
      final response = await apiClient.post(
        signUP,
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