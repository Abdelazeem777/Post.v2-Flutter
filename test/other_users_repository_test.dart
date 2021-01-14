import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:post/di/injection.dart';
import 'package:post/models/user.dart';
import 'package:post/services/currentUser.dart';
import 'package:post/services/socketService.dart';

main() {
  initHive();

  //generate 10 dummy users for testing
  List<User> _testingUsersList = List.generate(
      10,
      (i) => User(
            userName: "testing dummy user2${i + 1}",
            phoneNumber: '0111863106',
            email: 'testing_user2${i + 1}@test.com',
            password: 'TestingUser123',
            birthDate: DateTime.now()
                .subtract(
                    Duration(days: 365 * 25)) //date before 25 years from now
                .toLocal()
                .toString()
                .split(' ')[0],
          ));
  final _currentUserRepository = Injector().currentUserRepository;
  final _otherUsersRepository = Injector().otherUsersRepository;
  SocketService _socket = SocketService();

  WidgetsFlutterBinding.ensureInitialized();

  test('sign up with multiple testing users', () {
    _testingUsersList.forEach((user) {
      expect(
          () =>
              _currentUserRepository.singup(user).listen(expectAsync1((_) {})),
          returnsNormally);
    });
  });

  test('connect to socket', () {
    expect(_socket.connect, returnsNormally);
  });
  group('follow feature: ', () {
    test('search for a specific user to follow', () async {
      const searchText = 'testing dummy user';
      const resultUsersCount = 10;
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
      var targetUser = _testingUsersList[5];
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
    test('unfollow', () {
      var targetUser = _testingUsersList[5];
      _currentUserRepository
          .unFollow(CurrentUser().userID, targetUser.userID,
              CurrentUser().getRank(targetUser.userID))
          .listen(expectAsync1((_) {
        Future.delayed(Duration(seconds: 3)).then(expectAsync1((value) {
          //change it to future
          expect(CurrentUser().followingRankedList.contains(targetUser.userID),
              false);
        }));
      }));
    });
  });

  group('Following and followers List: ', () {
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
    test('follow', () {
      var targetUser = _testingUsersList[3];
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
    test('load followingList', () async {
      var loadFollowingUsersStream =
          _otherUsersRepository.loadFollowingUsers(CurrentUser().userID);
      await for (var user in loadFollowingUsersStream) {
        expect(CurrentUser().followingRankedList.contains(user.userID), true);
      }
    });
  });

  test('load followersList', () {
    final testUser = _testingUsersList[0];
    _otherUsersRepository
        .loadFollowersUsers(testUser.userID)
        .listen(expectAsync1((user) {
      final resultUserName = user.userName;
      final expectedUserName = CurrentUser().userName;
      expect(resultUserName, expectedUserName);
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
}

void initHive() {
  var path = Directory.current.path;
  path = path.split('/').takeWhile((item) => item != 'test').join('/');
  Hive.init('$path/test/hive_testing_path');
}
