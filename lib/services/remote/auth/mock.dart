import 'auth_service.dart';

class AuthServiceMock implements AuthService {
  static const String mockUserId = 'mock_user';

  @override
  Future<void> logout() async {}

  @override
  Future<bool> profileExists(String phone) async {
    return true; // TODO менять если нужны разные состояния того есть ли пользователь
  }

  @override
  Future<String> confirmCode(String id, String code) async {
    return mockUserId;
  }

  @override
  Future<String> confirmCredentials(credentials) async {
    return mockUserId;
  }

  @override
  Future<void> verifyPhone(
      String phone,
      Function(dynamic credentials) verificationCompleted,
      Function(String verificationId, int? token) onCodeSent,
      Function(Exception e)? onError) async {
    const bool exception = false;
    const bool received = false;

    if (exception && onError != null) {
      onError(Exception('Verify exception'));
      return;
    }

    if (received) {
      await verificationCompleted('1');
      return;
    }
    onCodeSent('1', null);
  }
}
