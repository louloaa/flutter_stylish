import 'package:flutter_stylish/features/authaintecation/domain/entities/user_request_entity.dart';
import '../repositories/auth_repository.dart';
// TODO CODE-REVIEW the code review that added must applying on whole file

class SignInUseCase {
  final AuthRepository authRepository;

  SignInUseCase({required this.authRepository});

  Future<String?> execute(UserRequestEntity userRequest) async {
    // Ensure that username and password are non-null
    if (userRequest.username == null || userRequest.password == null) {
      throw ArgumentError('Username or password cannot be null');
    }

    return await authRepository.signIn(userRequest.username!, userRequest.password!);
  }
}

