import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:login_app_ui/blocs/login/login_event.dart';
import 'package:login_app_ui/blocs/login/login_state.dart';
import 'package:login_app_ui/repository/auth_repository.dart';
import 'package:login_app_ui/utils/form_submission_status.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  LoginBloc({@required this.authRepository}) : super(LoginState());

  @override
  void onEvent(LoginEvent event) {
    log('EVENT $event');
    super.onEvent(event);
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginUsernameChanged) {
      yield state.copyWith(username: event.username);
    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);
    } else if (event is LoginValidated) {
      yield state.copyWith(status: FormValidated());
    } else if (event is LoginNotValidated) {
      yield state.copyWith(status: FormNotValidated());
    } else if (event is LoginSubmitted) {
      yield state.copyWith(status: FormSubmitting());
      try {
        await authRepository.login();
        yield state.copyWith(status: SubmissionSuccess());
      } catch (e) {
        log('Error $e');
        yield state.copyWith(status: SubmissionFailed(e));
      }
    }
  }
}
