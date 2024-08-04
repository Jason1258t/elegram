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

class UserNotFoundException implements Exception {
  final String? message;

  UserNotFoundException({this.message});

  @override
  String toString() {
    return 'User not found, message: $message';
  }
}