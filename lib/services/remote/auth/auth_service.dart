abstract interface class AuthService {
  Future<String> loginWithEmailAndPassword(String email, String password);

  Future<String> registerWithEmailAndPassword(String email, String password);

  Future<void> logout();
}
