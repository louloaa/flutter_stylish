import '../repositories/auth_repository.dart';
// TODO CODE-REVIEW the code review that added must applying on whole file

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  // TODO CODE-REVIEW use the request entity as named params
  Future<bool> execute(String username, String password) {
    return repository.signIn(username, password);
  }
}
