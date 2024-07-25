part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AppAuthState extends AuthState {}

class AppUnAuthState extends AuthState {}

final class AuthInProcessState extends AppUnAuthState {}

final class AuthErrorState extends AppUnAuthState {}
