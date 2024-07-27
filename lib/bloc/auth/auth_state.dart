part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

/// Приложение авторизовано, редирект на мейн
final class AppAuthState extends AuthState {}

/// Авторизация прошла в первый раз, показать онбординг и прочее
final class RegisteredState extends AuthState {}

/// Редирект на авторизацию, приложение не авторизовано
class AppUnAuthState extends AuthState {}

/// Загрузочка
final class AuthInProcessState extends AppUnAuthState {}

/// На экран с подтверждением смс
final class NeedSMSCodeState extends AppUnAuthState {}

final class AuthErrorState extends AppUnAuthState {}
