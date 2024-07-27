abstract interface class AuthService {
  Future<bool> profileExists(String phone);

  Future<void> verifyPhone(
      String phone,
      Function(dynamic) verificationCompleted,
      Function(String, int?) onCodeSent,
      Function(Exception)? onError);

  Future<String> confirmCode(String id, String code);

  Future<String> confirmCredentials(dynamic credentials);

  Future<void> logout();
}

enum VerificationStatusEnum { verified, error, codeSent, wrongCode }

