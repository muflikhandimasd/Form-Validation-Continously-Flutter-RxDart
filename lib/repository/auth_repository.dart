import 'dart:developer';

class AuthRepository {
  Future<void> login() async {
    log('ATTEMPT LOGIN');
    await Future.delayed(const Duration(seconds: 3));
    log('Login Success');
  }
}
