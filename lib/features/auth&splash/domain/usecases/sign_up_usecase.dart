import '../repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<bool> execute(Map<String, dynamic> userDetails) {
    return repository.signUp(userDetails);
  }
}
