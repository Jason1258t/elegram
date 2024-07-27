part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class VerifyPhoneEvent extends AuthEvent {
  final String phone;

  VerifyPhoneEvent(this.phone);
}

class VerifySMSCodeEvent extends AuthEvent {
  final String code;

  VerifySMSCodeEvent(this.code);
}

class LogoutEvent extends AuthEvent {}



// Эти ивенты вызываются только из блока же

class PhoneSuccessfulVerifiedEvent extends AuthEvent {}

class CodeSentEvent extends AuthEvent {}

class AuthErrorEvent extends AuthEvent {}

class CheckAuthStateEvent extends AuthEvent {}
