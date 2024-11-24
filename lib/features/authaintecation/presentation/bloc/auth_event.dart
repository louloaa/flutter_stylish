import 'package:equatable/equatable.dart';
// TODO CODE-REVIEW the code review that added must applying on whole file

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInEvent extends AuthEvent {
  final String username;
  final String password;

  SignInEvent(this.username, this.password);
  // TODO CODE-REVIEW add copy with method , is better for events in bloc
  // copyWith method for creating modified instances
  SignInEvent copyWith({
    String? username,
    String? password,
  }) {
    return SignInEvent(
      username ?? this.username,
      password ?? this.password,
    );
  }

  @override
  List<Object> get props => [username, password];
}

class SignUpEvent extends AuthEvent {
  final Map<String, dynamic> userDetails;

  SignUpEvent(this.userDetails);

  // copyWith method for creating modified instances
  SignUpEvent copyWith({
    Map<String, dynamic>? userDetails,
  }) {
    return SignUpEvent(
      userDetails ?? this.userDetails,
    );
  }

  @override
  List<Object> get props => [userDetails];
}