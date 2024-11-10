  import 'dart:convert';

  /// username : ""
  /// password : ""
  // TODO CODE-REVIEW this is an example of request entity
  UserRequestEntity userRequestEntityFromJson(String str) =>
      UserRequestEntity.fromJson(json.decode(str));

  String userRequestEntityToJson(UserRequestEntity data) =>
      json.encode(data.toJson());

  class UserRequestEntity {
    UserRequestEntity({
      String? username,
      String? password,
    }) {
      _username = username;
      _password = password;
    }

    UserRequestEntity.fromJson(dynamic json) {
      _username = json['username'];
      _password = json['password'];
    }

    String? _username;
    String? _password;

    UserRequestEntity copyWith({
      String? username,
      String? password,
    }) =>
        UserRequestEntity(
          username: username ?? _username,
          password: password ?? _password,
        );

    String? get username => _username;

    String? get password => _password;

    Map<String, dynamic> toJson() {
      final map = <String, dynamic>{};
      map['username'] = _username;
      map['password'] = _password;
      return map;
    }
  }
