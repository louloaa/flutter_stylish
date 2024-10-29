import '../repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<bool> execute(String username, String password) {
    return repository.signIn(username, password);
  }
}
