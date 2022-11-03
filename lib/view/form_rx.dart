import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:login_app_ui/form_validate_rx/form_validate_rx.dart';

class FormRX extends StatelessWidget {
  const FormRX({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('BUILDING AGAIN');
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<String>(
              stream: formValidateRx.email,
              builder: (_, snapShot) => TextField(
                onChanged: (val) => formValidateRx.sinkEmail.add(val),
                decoration: InputDecoration(
                    hintText: 'Email',
                    errorText:
                        snapShot.hasError ? snapShot.error.toString() : null),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            StreamBuilder<String>(
              stream: formValidateRx.password,
              builder: (_, snapShot) => TextField(
                onChanged: (val) => formValidateRx.sinkPassword.add(val),
                maxLengthEnforced: true,
                maxLength: 8,
                decoration: InputDecoration(
                    hintText: 'Password',
                    errorText:
                        snapShot.hasError ? snapShot.error.toString() : null),
                keyboardType: TextInputType.text,
                obscureText: true,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            StreamBuilder<bool>(
              stream: formValidateRx.submitValid,
              builder: (_, snapShot) => MaterialButton(
                onPressed: snapShot.data != true
                    ? () {}
                    : () {
                        print('true');
                      },
                child: Text(
                  'SUBMIT',
                  style: TextStyle(
                    letterSpacing: 1.4,
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
                color: snapShot.data != true
                    ? Colors.grey[200]
                    : Colors.deepPurpleAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
