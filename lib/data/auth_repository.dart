import 'dart:async';

import 'package:messenger_test/bloc/auth/auth_bloc.dart';
import 'package:messenger_test/services/remote/auth/auth_service.dart';
import 'package:messenger_test/utils/enums.dart';
import 'package:messenger_test/utils/exceptions.dart';
import 'package:rxdart/rxdart.dart';

interface class AuthRepository {
  final AuthService _authService;

  String? _currentUserId;
  String? _currentVerificationId;

  AuthRepository(this._authService);

  String? get userId => _currentUserId;

  Future<bool> profileExists() async {
    if (_currentUserId == null) {
     throw UserNotAuthorizedException();
    }

    return await _authService.profileExists(_currentUserId!);
  }

  Future<BehaviorSubject<VerificationStatusEnum>> verifyPhone(
      String phone) async {
    _currentVerificationId = null;

    final BehaviorSubject<VerificationStatusEnum> stream = BehaviorSubject();

    _authService.verifyPhone(phone, (credentials) async {
      await _confirmAuthorizationWithCredentials(credentials);
      stream.add(VerificationStatusEnum.verified);
    }, (verificationId, resendToken) {
      _currentVerificationId = verificationId;
      stream.add(VerificationStatusEnum.codeSent);
    }, (e) {
      stream.add(VerificationStatusEnum.error);
    });

    return stream;
  }

  Future<VerificationStatusEnum> verifySMSCode(String code) async {
    if (_currentVerificationId == null) throw NoVerificationIdException();

    final credentials =
        await _authService.confirmCode(_currentVerificationId!, code);
    try {
      await _confirmAuthorizationWithCredentials(credentials);
      return VerificationStatusEnum.verified;
    } catch (e) {
      return VerificationStatusEnum.wrongCode;
    }
  }

  Future<void> _confirmAuthorizationWithCredentials(dynamic credentials) async {
    _currentUserId = await _authService.confirmCredentials(credentials);
  }

  Future<AuthStatesEnum> checkAuthState() async {
    // TODO implement validation, now we can sets here state what we need

    return AuthStatesEnum.auth;
  }

  void logout() {
    _currentUserId = null;
  }
}
