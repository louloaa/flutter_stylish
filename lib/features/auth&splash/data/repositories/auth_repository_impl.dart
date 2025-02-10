import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import 'package:logger/logger.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final Logger logger = Logger();

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
Future<bool> signIn(String username, String password) async {
  try {
    // Call API to authenticate user and retrieve token
    final token = await remoteDataSource.signIn(username, password);

    // Check if the token is valid (not null)
    logger.i('Token received: $token');

    // Ensure the token is not null before storing it
    // Store the token in SharedPreferences
  
    logger.i('Token stored in SharedPreferences');
    return true; // Sign-in successful
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
