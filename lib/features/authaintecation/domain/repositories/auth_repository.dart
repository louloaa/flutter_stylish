// TODO CODE-REVIEW the code review that added must applying on whole file

abstract class AuthRepository {
  // TODO CODE-REVIEW use the request entity as named params

  Future<String?> signIn(String username, String password);
  Future<bool> signUp(Map<String, dynamic> userDetails);
}
