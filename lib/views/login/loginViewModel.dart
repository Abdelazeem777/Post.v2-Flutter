import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post/di/injection.dart';
import 'package:post/repositories/abstract/currentUserRepository.dart';

class LoginViewModel with ChangeNotifier {
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  bool busy = false;
  bool autoValidate = false;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  CurrentUserRepository _currentUserRepository;
  LoginViewModel() {
    _currentUserRepository = Injector().currentUserRepository;
  }

  void login({Function onLoginSuccess}) {
    _startLoading();
    if (formKey.currentState.validate()) {
      String email = emailController.text;
      String password = passwordController.text;
      _currentUserRepository.login(email, password)
        ..listen((_) {
          _stopLoadingOnLoginSuccess();
          onLoginSuccess();
        }).onError((err) {
          _stopLoadingOnLoginSuccess();
          _showSnackBarWithTheErrorMessage(err);
        });
    } else {
      _stopLoadingOnValidationFalse();
    }
  }

  void _stopLoadingOnValidationFalse() {
    autoValidate = true;
    busy = false;
    notifyListeners();
  }

  void _stopLoadingOnLoginSuccess() {
    busy = false;
    notifyListeners();
  }

  void _startLoading() {
    busy = true;
    notifyListeners();
  }

  void _showSnackBarWithTheErrorMessage(err) {
    final snackBar = SnackBar(content: Text(err.toString()));
    scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
