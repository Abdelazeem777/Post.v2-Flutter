import 'package:flutter/cupertino.dart';
import 'package:post/di/injection.dart';
import 'package:post/repositories/userRepository.dart';

class HomeTabViewModel with ChangeNotifier {}

class ProfileTabViewModel with ChangeNotifier {
  UserRepository _userRepository;
  ProfileTabViewModel() {
    _userRepository = Injector().usersRepository;
  }
  void logout({Function onLogoutSuccess}) {
    _userRepository.logout().listen((_) {
      onLogoutSuccess();
      notifyListeners();
    });
  }
}
