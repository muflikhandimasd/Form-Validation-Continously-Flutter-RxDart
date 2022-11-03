import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app_ui/blocs/login/login_bloc.dart';
import 'package:login_app_ui/blocs/login/login_event.dart';
import 'package:login_app_ui/repository/auth_repository.dart';
import 'package:login_app_ui/view/form_rx.dart';
import 'package:login_app_ui/view/login_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(
          create: (_) => AuthRepository(),
          child: BlocProvider(
              create: (context) =>
                  LoginBloc(authRepository: context.read<AuthRepository>())
                    ..add(LoginNotValidated()),
              child: FormRX())),
    );
  }
}
