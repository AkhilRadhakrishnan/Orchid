import 'package:flutter/material.dart';
import 'package:orchid/services/repository.dart';

class AuthenticationProvider with ChangeNotifier {
  final _repository = Repository();

  AuthenticationProvider? _login;
  AuthenticationProvider? get login => _login;

  set login(AuthenticationProvider? login) {
    _login = login;
    notifyListeners();
  }

  Future<void> validateLogin() async {
    login = await _repository.validateLogin();
    notifyListeners();
  }

  Future<void> validateOtp() async {
    login = await _repository.validateOtp();
    notifyListeners();
  }

  Future<void> logout() async {
    login = await _repository.logout();
    notifyListeners();
  }
}
