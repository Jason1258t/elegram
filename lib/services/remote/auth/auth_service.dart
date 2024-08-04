import 'package:messenger_test/models/user/user.dart';

abstract interface class AuthService {
  Future<bool> profileExists(String id);

  Future<void> verifyPhone(
      String phone,
      {required Function(dynamic) verificationCompleted,
      required Function(String, int?) onCodeSent,
      Function(Exception)? onError});

  Future<String> confirmCode(String id, String code);

  Future<String> confirmCredentials(dynamic credentials);

  Future<void> logout();

  Future<void> registerUserProfile(User user);

  Future<bool> authorized();

  Future<String> currentUserId();
}

enum VerificationStatusEnum { verified, error, codeSent, wrongCode }
