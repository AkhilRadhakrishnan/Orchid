import 'package:flutter/material.dart';
import 'package:orchid/services/repository.dart';

class LoginProvider with ChangeNotifier {
  final _repository = Repository();

  LoginProvider? _login;
  LoginProvider? get login => _login;

  set login(LoginProvider? login) {
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
}
