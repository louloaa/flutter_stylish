// data/datasources/remote_data_source.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getUserProfile(int userId);
  Future<void> updateUserProfile(UserModel user);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> getUserProfile(int userId) async {
    final response = await client.get(Uri.parse('https://fakestoreapi.com/users/$userId'));
    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  @override
  Future<void> updateUserProfile(UserModel user) async {
    final response = await client.put(
      Uri.parse('https://fakestoreapi.com/users/7'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update user profile');
    }
  }
}
