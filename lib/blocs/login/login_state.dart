import 'package:login_app_ui/utils/form_submission_status.dart';

class LoginState {
  final String username;
  bool get isValidUsername {
    if (username.length < 3) {
      return false;
    } else {
      return true;
    }
  }

  bool get isValidPassword {
    if (password.length < 9) {
      return false;
    } else {
      return true;
    }
  }

  final String password;
  final FormSubmissionStatus status;
  LoginState(
      {this.username = '',
      this.password = '',
      this.status = const InitialFormStatus()});

  LoginState copyWith(
          {String username, String password, FormSubmissionStatus status}) =>
      LoginState(
        username: username ?? this.username,
        password: password ?? this.password,
        status: status ?? this.status,
      );
}
