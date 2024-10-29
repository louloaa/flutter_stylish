// data/models/user_model.dart
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.username,
    required super.password,
    required super.city,
    required super.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      password: json['password'],
      city: json['address']['city'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'address': {
        'city': city,
      },
      'phone': phone,
    };
  }
}
