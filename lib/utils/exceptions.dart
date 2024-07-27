class NoVerificationIdException implements Exception {
  @override
  String toString() {
    return 'no verification id to verify code, try to use [verifyPhone] first';
  }
}

class UserNotAuthorizedException implements Exception {
  @override
  String toString() {
    return 'User not authorized yet';
  }
}