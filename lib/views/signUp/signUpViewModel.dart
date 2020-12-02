import 'package:flutter/material.dart';
import 'package:post/di/injection.dart';
import 'package:post/models/user.dart';
import 'package:post/repositories/currentUserRepository.dart';

class SignUpViewModel with ChangeNotifier {
  final FocusNode userNameFocusNode = FocusNode();
  final FocusNode birthDateFocusNode = FocusNode();
  final FocusNode phoneNumberFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  TextEditingController userNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  bool autoValidate = false;
  bool busy = false;

  CurrentUserRepository _currentUserRepository;
  SignUpViewModel() {
    _currentUserRepository = Injector().currentUserRepository;
  }
  void signUp({Function onSignUpSuccess}) {
    _startLoading();
    if (formKey.currentState.validate()) {
      User newUser = _getNewUserWithInputDate();
      _currentUserRepository.singup(newUser).listen((_) {
        _stopLoadingOnSignUpSuccess();
        onSignUpSuccess();
      }).onError((err) {
        _stopLoadingOnSignUpSuccess();
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

  void _stopLoadingOnSignUpSuccess() {
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

  User _getNewUserWithInputDate() => User()
    ..userName = userNameController.text
    ..email = emailController.text
    ..password = passwordController.text
    ..birthDate = birthDateController.text
    ..phoneNumber = phoneNumberController.text;
}
