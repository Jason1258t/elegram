import 'package:bloc/bloc.dart';
import 'package:messenger_test/data/auth_repository.dart';
import 'package:messenger_test/services/remote/auth/auth_service.dart';
import 'package:messenger_test/utils/enums.dart';
import 'package:meta/meta.dart';

import '../../data/repository_with_authorize.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  final List<RepositoryWithAuthorization>? repositories;

  AuthBloc(AuthRepository authRepository, [this.repositories])
      : _authRepository = authRepository,
        super(AuthInitial()) {
    on<CheckAuthStateEvent>(_checkAuth);
    on<LogoutEvent>(_onLogout);
    on<VerifyPhoneEvent>(_verifyPhone);
    on<CodeSentEvent>(_onCodeSent);
    on<AuthErrorEvent>(_onError);
    on<PhoneSuccessfulVerifiedEvent>(_onVerified);

    add(CheckAuthStateEvent());
  }

  _checkAuth(CheckAuthStateEvent event, emit) async {
    final appState = await _authRepository.checkAuthState();
    if (appState == AuthStatesEnum.auth) {
      final account = _authRepository.account!;

      for (RepositoryWithAuthorization rep in repositories ?? []) {
        rep.initialize(account);
      }

      emit(AppAuthState());
    }
    if (appState == AuthStatesEnum.unAuth) emit(AppUnAuthState());
  }

  _verifyPhone(VerifyPhoneEvent event, emit) async {
    emit(AuthInProcessState());
    final stream = await _authRepository.verifyPhone(event.phone);

    stream.listen((status) {
      switch (status) {
        case VerificationStatusEnum.verified:
          add(PhoneSuccessfulVerifiedEvent());
        case VerificationStatusEnum.codeSent:
          add(CodeSentEvent());
        default:
          add(AuthErrorEvent());
      }
    });
  }

  /// Shows if you need to enter sms code
  _onCodeSent(CodeSentEvent event, emit) async {
    emit(NeedSMSCodeState());
  }

  /// calls when user's phone verified, emits [AppAuthState] if it's login
  /// and [RegisteredState] when it's registration
  _onVerified(PhoneSuccessfulVerifiedEvent event, emit) async {
    emit(AuthInProcessState());
    final profileExists = await _authRepository.profileExists();

    if (profileExists) {
      emit(AppAuthState());
    } else {
      emit(RegisteredState());
    }
  }

  _onError(AuthErrorEvent event, emit) {
    emit(AuthErrorState());
  }

  _onLogout(LogoutEvent event, emit) async {
    _authRepository.logout();
  }
}
