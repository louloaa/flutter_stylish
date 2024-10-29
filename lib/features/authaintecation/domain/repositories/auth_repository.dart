abstract class AuthRepository {
  Future<bool> signIn(String username, String password);
  Future<bool> signUp(Map<String, dynamic> userDetails);
}
