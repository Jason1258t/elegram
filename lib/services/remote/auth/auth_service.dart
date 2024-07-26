abstract interface class AuthService {
  Future<bool> userExists(String phone);

  Future<String> registerByPhone(String phone);

  Future<String> loginWithPhone(String phone);

  Future<String> loginWithEmailAndPassword(String email, String password);

  Future<String> registerWithEmailAndPassword(String email, String password);

  Future<void> verifyPhone(
      String phone,
      Function(dynamic) verificationCompleted,
      Function(String, int?) onCodeSent,
      Function(Exception)? onError);

  Future<String> confirmCode(String id, String code);

  Future<String> confirmCredentials(dynamic credentials);

  Future<void> logout();
}

