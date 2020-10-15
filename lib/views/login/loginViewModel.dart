import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post/di/injection.dart';
import 'package:post/repositories/userRepository.dart';

class LoginViewModel with ChangeNotifier {
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  bool busy = false;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  UserRepository _userRepository;
  LoginViewModel() {
    _userRepository = Injector().usersRepository;
  }

  Stream<void> login({Function onLoginSuccess}) {
    _startLoading();
    String email = emailController.text;
    String password = passwordController.text;
    return _userRepository.login(email, password)
      ..listen((_) {
        _stopLoadingOnLoginSuccess();
        onLoginSuccess();
      }).onError((err) {
        _stopLoadingOnLoginSuccess();
        _showSnackBarWithTheErrorMessage(err);
      });
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
