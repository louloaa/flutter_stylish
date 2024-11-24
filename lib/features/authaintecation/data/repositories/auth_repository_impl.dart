import 'package:flutter_stylish/features/authaintecation/domain/entities/user_request_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import 'package:logger/logger.dart';
// TODO CODE-REVIEW the code review that added must applying on whole file

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final Logger logger = Logger();

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
 Future<String?>signIn(String username, String password) async {
    try {
      // Call API to authenticate user and retrieve token
      final String? token = await remoteDataSource.signIn(
        entity: UserRequestEntity(username: username, password: password),
      );

      // Log and return the token
      if (token != null) {
        logger.i('Token received: $token');
        return token; // Return token if authentication is successful
      } else {
        logger.w('Sign-in failed: Token is null');
        return null; // Return null if token is not found
      }
    } catch (e) {
      logger.e('Error during signIn: $e');
      throw UserNotFoundException("Error during sign-in: ${e.toString()}");
    }
  }

  @override
  Future<bool> signUp(Map<String, dynamic> userDetails) async {
    logger.i('SignUp attempt with userDetails: $userDetails');

    final success = await remoteDataSource.signUp(userDetails);
    if (success) {
      // Store username and password securely after successful sign-up
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(userDetails['username'], userDetails['password']);
      logger.i('Username and password stored after sign-up');
      return true;
    }

    logger.w('Sign-up failed');
    return false; // Sign-up failed
  }
}

class UserNotFoundException implements Exception {
  final String message;

  UserNotFoundException(
      [this.message = "User not found or invalid credentials"]);

  @override
  String toString() => message;
}
