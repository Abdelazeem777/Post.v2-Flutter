import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:post/di/injection.dart';
import 'package:post/models/user.dart';
import 'package:post/repositories/abstract/currentUserRepository.dart';
import 'package:post/services/currentUser.dart';
import 'package:post/services/socketService.dart';

main() {
  group('Normal user: ', () {
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
    CurrentUserRepository _currentUserRepository =
        Injector().currentUserRepository;
    WidgetsFlutterBinding.ensureInitialized();
    //-------------------------|Singup|---------------------------
    test('Signup with valid inputs', () {
      expect(
          () => _currentUserRepository
              .singup(_testingUser)
              .listen(expectAsync1((_) {})),
          returnsNormally);
    });
    test('Signup with existing email', () {
      _currentUserRepository
          .singup(_testingUser)
          .listen((_) {})
          .onError(expectAsync1((e) {
        expect(e.toString(), 'This email is already exist!');
      }));
    });

    //-------------------------|Login|----------------------------
    test('Login with wrong email', () {
      _currentUserRepository
          .login('wrongEmail@test.com', _testingUser.password)
          .listen((_) {})
          .onError(expectAsync1((e) {
        expect(e.toString(), 'Invalid Email or Password!');
      }));
    });
    test('Login with wrong password', () async* {
      _currentUserRepository
          .login(_testingUser.email, 'wrongPassword')
          .listen((_) {})
          .onError(expectAsync1((e) {
        expect(e.toString(), 'Invalid Email or Password!');
      }));
    });
    test('Login with valid inputs', () {
      expect(
          () => _currentUserRepository
              .login(_testingUser.email, _testingUser.password)
              .listen(expectAsync1((_) {})),
          returnsNormally);
    });

    //---------------------|Delete Account|-----------------------
    test('Delete nonexisting account', () {
      _currentUserRepository
          .deleteAccount('dummy_email@email.com')
          .listen((_) {})
          .onError(expectAsync1((e) {
        expect(e.toString(), 'This account is not exist!');
      }));
    });
    test('Delete existing account', () {
      _currentUserRepository
          .deleteAccount(_testingUser.email)
          .listen(expectAsync1((res) {
        expect(res, 'Deleted successfully');
      }));
    });
  });

  group('Google login: ', () {
    CurrentUserRepository _currentUserRepository =
        Injector().currentUserRepository;
    User _googleUser = User(
      userName: "Google Account",
      userProfilePicURL: "http://Google_profile_picture.jpg",
      userID: "1111111111111",
      email: "googleAccount@gmail.com",
    );
    test('login with valid account', () {
      _currentUserRepository
          .alternateLogin(_googleUser)
          .listen(expectAsync1((_) {
        User actualUser = CurrentUser();
        User matcherUser = _googleUser.copyWith();
        expect(actualUser, matcherUser);
      }));
    });

    test('login with valid account but with new profile picture', () {
      User _googleUserWithNewProfilePic = _googleUser.copyWith(
          userProfilePicURL: "http://New_Google_profile_picture.jpg");
      _currentUserRepository
          .alternateLogin(_googleUserWithNewProfilePic)
          .listen(expectAsync1((_) {
        User actualUser = CurrentUser();
        User matcherUser = _googleUserWithNewProfilePic.copyWith();
        expect(actualUser, matcherUser);
      }));
    });
    test('Delete existing account', () {
      _currentUserRepository
          .deleteAccount(_googleUser.email)
          .listen(expectAsync1((res) {
        expect(res, 'Deleted successfully');
      }));
    });
  });

  group('Facebook login: ', () {
    CurrentUserRepository _currentUserRepository =
        Injector().currentUserRepository;
    User _facebookUser = User(
      userName: "Facebook Account",
      userProfilePicURL: "http://Facebook_profile_picture.jpg",
      userID: "1111111111111",
      email: "facebookAccount@gmail.com",
    );
    test('login with valid account', () {
      _currentUserRepository
          .alternateLogin(_facebookUser)
          .listen(expectAsync1((_) {
        User actualUser = CurrentUser();
        User matcherUser = _facebookUser.copyWith();
        expect(actualUser, matcherUser);
      }));
    });

    test('login with valid account but with new profile picture', () {
      User _facebookUserWithNewProfilePic = _facebookUser.copyWith(
          userProfilePicURL: "http://New_Facebook_profile_picture.jpg");
      _currentUserRepository
          .alternateLogin(_facebookUserWithNewProfilePic)
          .listen(expectAsync1((_) {
        User actualUser = CurrentUser();
        User matcherUser = _facebookUserWithNewProfilePic.copyWith();
        expect(actualUser, matcherUser);
      }));
    });
    test('Delete existing account', () {
      _currentUserRepository
          .deleteAccount(_facebookUser.email)
          .listen(expectAsync1((res) {
        expect(res, 'Deleted successfully');
      }));
    });
  });

  group("update userProfilePic", () {
    String _imageBase64 =
        'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVQYV2NgYAAAAAMAAWgmWQ0AAAAASUVORK5CYII=';
    String _ext = 'png';
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
    CurrentUserRepository _currentUserRepository =
        Injector().currentUserRepository;

    WidgetsFlutterBinding.ensureInitialized();

    test('Signup with valid inputs', () {
      expect(
          () => _currentUserRepository
              .singup(_testingUser)
              .listen(expectAsync1((_) {})),
          returnsNormally);
    });
    group('login and change the userProfilePic', () {
      test('Login with valid inputs', () {
        expect(
            () => _currentUserRepository
                .login(_testingUser.email, _testingUser.password)
                .listen(expectAsync1((_) {})),
            returnsNormally);
      });
      test('test update userProfilePic', () {
        expect(
            () => _currentUserRepository
                .uploadProfilePic({'base64': _imageBase64, 'ext': _ext}).listen(
                    expectAsync1((_) {})),
            returnsNormally);
      });

      test('check the new value of userProfilePic exists in prefs', () {
        String matcher = CurrentUser().userProfilePicURL;
        CurrentUser()
            .loadCurrentUserDataFromPreference()
            .then((user) => expect(user.userProfilePicURL, matcher));
      });
    });

    test('Delete existing account', () {
      _currentUserRepository
          .deleteAccount(_testingUser.email)
          .listen(expectAsync1((res) {
        expect(res, 'Deleted successfully');
      }));
    });
  });
  group('Update profile data: ', () {
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
    var newUserName = 'New User Name';
    var newBio = 'hey there I am still using post app';
    CurrentUserRepository _currentUserRepository =
        Injector().currentUserRepository;

    WidgetsFlutterBinding.ensureInitialized();

    test('Signup with valid inputs', () {
      expect(
          () => _currentUserRepository
              .singup(_testingUser)
              .listen(expectAsync1((_) {})),
          returnsNormally);
    });

    test('update userName and Bio', () {
      _currentUserRepository
          .updateProfileData(newUserName, newBio)
          .listen(expectAsync1((response) {
        expect(CurrentUser().userName, newUserName);
        expect(CurrentUser().bio, newBio);
        expect(response, 'Updated successfully');
      }));
    });

    test('Login with valid inputs', () {
      _currentUserRepository
          .login(_testingUser.email, _testingUser.password)
          .listen(expectAsync1((_) {
        expect(CurrentUser().userName, newUserName);
        expect(CurrentUser().bio, newBio);
      }));
    });

    test('Delete existing account', () {
      _currentUserRepository
          .deleteAccount(_testingUser.email)
          .listen(expectAsync1((res) {
        expect(res, 'Deleted successfully');
      }));
    });
  });

  group('Ranking: ', () {
    List<User> _testingUsersList = List.generate(
      4,
      (i) => User(
        userName: "testing3 dummy user${i + 1}",
        phoneNumber: '0111863106',
        email: 'testing3_user${i + 1}@test.com',
        password: 'TestingUser123',
        birthDate: DateTime.now()
            .subtract(Duration(days: 365 * 25)) //date before 25 years from now
            .toLocal()
            .toString()
            .split(' ')[0],
      ),
    );
    final _currentUserRepository = Injector().currentUserRepository;
    final _otherUsersRepository = Injector().otherUsersRepository;
    SocketService _socket = SocketService();

    WidgetsFlutterBinding.ensureInitialized();
    test('sign up with multiple testing users', () {
      _testingUsersList.forEach((user) {
        expect(
            () => _currentUserRepository
                .singup(user)
                .listen(expectAsync1((_) {})),
            returnsNormally);
      });
    });

    test('connect to socket', () {
      expect(_socket.connect, returnsNormally);
    });
    test('search for a specific user to follow', () async {
      const searchText = 'testing3 dummy user';
      const resultUsersCount = 4;
      await for (var user in _otherUsersRepository.searchForUsers(searchText)) {
        _testingUsersList = _testingUsersList.map((testUser) {
          if (user.userName == testUser?.userName)
            testUser.userID = user.userID;
          return testUser;
        }).toList();
        expect(_testingUsersList.length, resultUsersCount);
      }
    });
    test('follow', () {
      var targetUser = _testingUsersList[0];
      _currentUserRepository
          .follow(
              CurrentUser().userID, targetUser.userID, CurrentUser().getRank())
          .listen(expectAsync1((_) {
        Future.delayed(Duration(seconds: 3)).then(expectAsync1((_) {
          expect(CurrentUser().followingRankedList.contains(targetUser.userID),
              true);
        }));
      }));
    });
    test('follow', () {
      var targetUser = _testingUsersList[1];
      _currentUserRepository
          .follow(
              CurrentUser().userID, targetUser.userID, CurrentUser().getRank())
          .listen(expectAsync1((_) {
        Future.delayed(Duration(seconds: 3)).then(expectAsync1((_) {
          expect(CurrentUser().followingRankedList.contains(targetUser.userID),
              true);
        }));
      }));
    });
    test('follow', () {
      var targetUser = _testingUsersList[2];
      _currentUserRepository
          .follow(
              CurrentUser().userID, targetUser.userID, CurrentUser().getRank())
          .listen(expectAsync1((_) {
        Future.delayed(Duration(seconds: 3)).then(expectAsync1((_) {
          expect(CurrentUser().followingRankedList.contains(targetUser.userID),
              true);
        }));
      }));
    });

    /// TODO: add the expect method
    test('change rank of some user from first to last', () {
      final targetUserID = _testingUsersList[0].userID;
      final newRank = 1;
      var oldRank = CurrentUser().getRank(targetUserID);
      _currentUserRepository
          .updateRank(CurrentUser().userID, targetUserID, oldRank, newRank)
          .listen(expectAsync1((res) {
        final actualRank =
            CurrentUser().followingRankedList.indexOf(targetUserID);
        final expectedRank = newRank;
        expect(actualRank, expectedRank);
        expect(res, "Done");
      }));
    });

    test('delete testing users', () {
      _testingUsersList.forEach((user) {
        _currentUserRepository
            .deleteAccount(user.email)
            .listen(expectAsync1((res) {
          expect(res, 'Deleted successfully');
        }));
      });
    });

    test('disconnect socket connection', () {
      expect(() => _socket.disconnect(), returnsNormally);
    });
  });
}
