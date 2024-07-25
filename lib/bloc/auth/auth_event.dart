part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginWithEmailAndPasswordEvent extends AuthEvent {
  final String email;
  final String password;

  LoginWithEmailAndPasswordEvent(this.email, this.password);
}

class RegisterWithEmailAndPasswordEvent extends AuthEvent {
  final String email;
  final String password;

  RegisterWithEmailAndPasswordEvent(this.email, this.password);
}

class LogoutEvent extends AuthEvent {}

class CheckAuthStateEvent extends AuthEvent {}
