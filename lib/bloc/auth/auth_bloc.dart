import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:messenger_test/utils/enums.dart';


import '../../data/auth_repository.dart';
import '../../services/remote/auth/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<VerifyPhoneEvent>(_onVerifyPhone);
    on<VerifySMSCodeEvent>(_onVerifySMSCode);
    on<LogoutEvent>(_onLogout);
    on<CheckAuthStateEvent>(_onCheckAuthState);
  }

  void _onVerifyPhone(VerifyPhoneEvent event, Emitter<AuthState> emit) async {
    emit(AuthInProcessState());
    try {
      final stream = await _authRepository.verifyPhone(event.phone);
      await emit.forEach(
        stream,
        onData: (VerificationStatusEnum status) {
          if (status == VerificationStatusEnum.verified) {
            return AppAuthState();
          } else if (status == VerificationStatusEnum.codeSent) {
            return NeedSMSCodeState();
          } else {
            return AuthErrorState();
          }
        },
      );
    } catch (e) {
      emit(AuthErrorState());
    }
  }

  void _onVerifySMSCode(VerifySMSCodeEvent event, Emitter<AuthState> emit) async {
    emit(AuthInProcessState());
    try {
      final status = await _authRepository.verifySMSCode(event.code);
      if (status == VerificationStatusEnum.verified) {
        emit(AppAuthState());
      } else {
        emit(AuthErrorState());
      }
    } catch (e) {
      emit(AuthErrorState());
    }
  }

  void _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    _authRepository.logout();
    emit(AppUnAuthState());
  }

  void _onCheckAuthState(CheckAuthStateEvent event, Emitter<AuthState> emit) async {
    final state = await _authRepository.checkAuthState();
    if (state == AuthStatesEnum.auth) {
      emit(AppAuthState());
    } else {
      emit(AppUnAuthState());
    }
  }
}
