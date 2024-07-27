import 'package:bloc/bloc.dart';
import 'package:messenger_test/data/auth_repository.dart';
import 'package:messenger_test/services/remote/auth/auth_service.dart';
import 'package:messenger_test/utils/enums.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
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
    if (appState == AuthStatesEnum.auth) emit(AppAuthState());
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

  _onCodeSent(CodeSentEvent event, emit) async {
    emit(NeedSMSCodeState());
  }

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
