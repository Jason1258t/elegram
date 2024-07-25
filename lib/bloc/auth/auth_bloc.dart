import 'package:bloc/bloc.dart';
import 'package:messenger_test/data/auth_repository.dart';
import 'package:messenger_test/utils/enums.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<CheckAuthStateEvent>(_checkAuth);
    on<LoginWithEmailAndPasswordEvent>(_onLoginWithEmailAndPassword);
    on<RegisterWithEmailAndPasswordEvent>(_onRegisterWithEmailAndPassword);
    on<LogoutEvent>(_onLogout);

    add(CheckAuthStateEvent());
  }

  _onLoginWithEmailAndPassword(
      LoginWithEmailAndPasswordEvent event, emit) async {
    emit(AuthInProcessState());
    final userId = await _authRepository.loginWithEmailAndPassword(
        event.email, event.password);

    emit(AppAuthState());
  }

  _onRegisterWithEmailAndPassword(
      RegisterWithEmailAndPasswordEvent event, emit) async {
    emit(AuthInProcessState());
    final userId = await _authRepository.registerWithEmailAndPassword(
        event.email, event.password);
    emit(AppAuthState());
  }

  _checkAuth(CheckAuthStateEvent event, emit) async {
    final appState = await _authRepository.checkAuthState();
    if (appState == AuthStatesEnum.auth) emit(AppAuthState());
    if (appState == AuthStatesEnum.unAuth) emit(AppUnAuthState());
  }

  _onLogout(LogoutEvent event, emit) async {
    _authRepository.logout();
  }
}
