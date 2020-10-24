import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:post/di/injection.dart';
import 'package:post/models/user.dart';
import 'package:post/repositories/userRepository.dart';
import 'package:post/services/currentUser.dart';
import 'package:rxdart/rxdart.dart';

main() {
  group('Normal user: ', () {
    @visibleForTesting
    User _testingUser = User(
      userName: "testing user",
      phoneNumber: '0111863106',
      email: 'testing_user@test.com',
      password: 'TestingUser123',
      birthDate: DateTime.now()
          .subtract(Duration(days: 365 * 25)) //date before 25 years from now
          .toLocal()
          .toString()
          .split(' ')[0],
    );
    @visibleForTesting
    UserRepository _userRepository = Injector().usersRepository;
    WidgetsFlutterBinding.ensureInitialized();
    //-------------------------|Singup|---------------------------
    test('Signup with valid inputs', () {
      expect(
          () =>
              _userRepository.singup(_testingUser).listen(expectAsync1((_) {})),
          returnsNormally);
    });
    test('Signup with existing email', () {
      _userRepository
          .singup(_testingUser)
          .listen((_) {})
          .onError(expectAsync1((e) {
        expect(e.toString(), 'This email is already exist!');
      }));
    });

    //-------------------------|Login|----------------------------
    test('Login with wrong email', () {
      _userRepository
          .login('wrongEmail@test.com', _testingUser.password)
          .listen((_) {})
          .onError(expectAsync1((e) {
        expect(e.toString(), 'Invalid Email or Password!');
      }));
    });
    test('Login with wrong password', () async* {
      _userRepository
          .login(_testingUser.email, 'wrongPassword')
          .listen((_) {})
          .onError(expectAsync1((e) {
        expect(e.toString(), 'Invalid Email or Password!');
      }));
    });
    test('Login with valid inputs', () {
      expect(
          () => _userRepository
              .login(_testingUser.email, _testingUser.password)
              .listen(expectAsync1((_) {})),
          returnsNormally);
    });

    //---------------------|Delete Account|-----------------------
    test('Delete nonexisting account', () {
      _userRepository
          .deleteAccount('dummy_email@email.com')
          .listen((_) {})
          .onError(expectAsync1((e) {
        expect(e.toString(), 'This account is not exist!');
      }));
    });
    test('Delete existing account', () {
      _userRepository
          .deleteAccount(_testingUser.email)
          .listen(expectAsync1((res) {
        expect(res, 'Deleted successfully');
      }));
    });
  });

  group('Google login: ', () {
    UserRepository _userRepository = Injector().usersRepository;
    User _googleUser = User(
      userName: "Google Account",
      userProfilePicURL: "Google_profile_picture.jpg",
      userID: "1111111111111",
      email: "googleAccount@gmail.com",
    );
    test('login with valid account', () {
      _userRepository.alternateLogin(_googleUser).listen(expectAsync1((_) {
        User actualUser = CurrentUser();
        User matcherUser = _googleUser.copyWith()..email = null;
        expect(actualUser, matcherUser);
      }));
    });

    test('login with valid account but with new profile picture', () {
      User _googleUserWithNewProfilePic = _googleUser.copyWith(
          userProfilePicURL: "New_Google_profile_picture.jpg");
      _userRepository
          .alternateLogin(_googleUserWithNewProfilePic)
          .listen(expectAsync1((_) {
        User actualUser = CurrentUser();
        User matcherUser = _googleUserWithNewProfilePic.copyWith()
          ..email = null;
        expect(actualUser, matcherUser);
      }));
    });
    test('Delete existing account', () {
      _userRepository
          .deleteAccount(_googleUser.email)
          .listen(expectAsync1((res) {
        expect(res, 'Deleted successfully');
      }));
    });
  });

  group('Facebook login: ', () {
    UserRepository _userRepository = Injector().usersRepository;
    User _facebookUser = User(
      userName: "Facebook Account",
      userProfilePicURL: "Facebook_profile_picture.jpg",
      userID: "1111111111111",
      email: "facebookAccount@gmail.com",
    );
    test('login with valid account', () {
      _userRepository.alternateLogin(_facebookUser).listen(expectAsync1((_) {
        User actualUser = CurrentUser();
        User matcherUser = _facebookUser.copyWith()..email = null;
        expect(actualUser, matcherUser);
      }));
    });

    test('login with valid account but with new profile picture', () {
      User _facebookUserWithNewProfilePic = _facebookUser.copyWith(
          userProfilePicURL: "New_Facebook_profile_picture.jpg");
      _userRepository
          .alternateLogin(_facebookUserWithNewProfilePic)
          .listen(expectAsync1((_) {
        User actualUser = CurrentUser();
        User matcherUser = _facebookUserWithNewProfilePic.copyWith()
          ..email = null;
        expect(actualUser, matcherUser);
      }));
    });
    test('Delete existing account', () {
      _userRepository
          .deleteAccount(_facebookUser.email)
          .listen(expectAsync1((res) {
        expect(res, 'Deleted successfully');
      }));
    });
  });
}
