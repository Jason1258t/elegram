import 'dart:async';

import 'package:messenger_test/services/remote/auth/auth_service.dart';
import 'package:messenger_test/utils/enums.dart';

class AuthRepository {
  final AuthService _authService;

  String? _currentUserId;

  AuthRepository(this._authService);

  Future<bool> userExists(String phone) => _authService.userExists(phone);

  Future<String> registerWithPhone(String phone) async {
    _currentUserId = await _authService.registerByPhone(phone);
    return _currentUserId!;
  }

  Future<String> loginWithPhone(String phone) async {
    _currentUserId = await _authService.registerByPhone(phone);
    return _currentUserId!;
  }

  Future<String> loginWithEmailAndPassword(
      String email, String password) async {
    _currentUserId =
        await _authService.loginWithEmailAndPassword(email, password);
    return _currentUserId!;
  }

  Future<String> registerWithEmailAndPassword(
      String email, String password) async {
    _currentUserId =
        await _authService.registerWithEmailAndPassword(email, password);
    return _currentUserId!;
  }

  Future<AuthStatesEnum> checkAuthState() async {
    // TODO implement validation, now we can sets here state what we need

    return AuthStatesEnum.auth;
  }

  String? get userId => _currentUserId;

  void logout() {
    _currentUserId = null;
  }
}
