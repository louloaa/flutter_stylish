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
  @override
  List<Object> get props => [username, password];
}

class SignUpEvent extends AuthEvent {
  final Map<String, dynamic> userDetails;

  SignUpEvent(this.userDetails);

  @override
  List<Object> get props => [userDetails];
}
