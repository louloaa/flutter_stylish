import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInEvent extends AuthEvent {
  final String username;
  final String password;

  SignInEvent(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}

class SignUpEvent extends AuthEvent {
  final Map<String, dynamic> userDetails;

  SignUpEvent(this.userDetails);

  @override
  List<Object> get props => [userDetails];
}
