import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app_ui/blocs/login/login_bloc.dart';
import 'package:login_app_ui/blocs/login/login_event.dart';
import 'package:login_app_ui/blocs/login/login_state.dart';
import 'package:login_app_ui/utils/form_submission_status.dart';

class LoginView extends StatelessWidget {
  LoginView({Key key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loginForm(),
    );
  }

  Widget _loginForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _usernameField(),
            _passwordField(),
            const SizedBox(
              height: 30,
            ),
            _loginButton()
          ],
        ),
      ),
    );
  }

  Widget _usernameField() => BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.username != current.username,
        builder: (context, state) => TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (value) {
            context.read<LoginBloc>().add(LoginUsernameChanged(value));
          },
          validator: (value) {
            return state.isValidUsername ? null : 'Username is too short';
          },
          decoration: const InputDecoration(
              icon: Icon(Icons.person), labelText: 'Username'),
        ),
      );
  Widget _passwordField() => BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) => TextFormField(
          obscureText: true,
          maxLength: 9,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (value) {
            log('STATE IS VALIDPASS ${state.isValidPassword}');
            context.read<LoginBloc>().add(LoginPasswordChanged(value));
          },
          validator: (value) {
            return state.isValidPassword ? null : 'Password is too short';
          },
          decoration: const InputDecoration(
            icon: Icon(Icons.security),
            labelText: 'Password',
          ),
        ),
      );

  Widget _loginButton() => BlocConsumer<LoginBloc, LoginState>(
      listenWhen: (previous, current) {
        if (previous.username != current.username) {
          return true;
        } else if (previous.password != current.password) {
          return true;
        } else {
          return false;
        }
      },
      listener: (context, state) {
        if (!_formKey.currentState.validate()) {
          log('EKSEKUSI');
          context.read<LoginBloc>().add(LoginNotValidated());
        }
        if (_formKey.currentState.validate()) {
          context.read<LoginBloc>().add(LoginValidated());
        }
      },
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status is FormSubmitting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: changeColorButton(state)),
            onPressed: () {},
            child: Text(
              'Login',
            ),
          ),
        );
      });

  changeColorButton(LoginState state) {
    if (state.status is FormValidated) {
      return Colors.blue;
    } else {
      return Colors.grey;
    }
  }
}
