import 'dart:convert';
import 'package:flutter_stylish/core/util/api.dart';
import 'package:flutter_stylish/core/util/http.dart';
import '../models/user_model.dart';

// TODO CODE-REVIEW use the same TODO notes in previous data source
abstract class UserRemoteDataSource {
  Future<UserModel> getUserProfile(int userId);
  Future<void> updateUserProfile(UserModel user);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {

  @override
  Future<UserModel> getUserProfile(int userId) async {
    try {
      final response = await apiClient.get('$profile$userId');
      if (response.statusCode == 200) {
        return UserModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load user profile. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error loading user profile: $e');
    }
  }
  
@override
  Future<void> updateUserProfile(UserModel user) async {
    try {
      final response = await apiClient.put(
        updateProfile, // Replace with the actual update profile URL
        body: json.encode(user.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update user profile. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating user profile: $e');
    }
  }

}
