import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:post/di/injection.dart';
import 'package:post/models/user.dart';
import 'package:post/services/currentUser.dart';
import 'package:post/services/socketService.dart';

main() {
  //generate 10 dummy users for testing
  List<User> _testingUsersList = List.generate(
      10,
      (i) => User(
            userName: "testing dummy2 user${i + 1}",
            phoneNumber: '0111863106',
            email: 'testing2_user${i + 1}@test.com',
            password: 'TestingUser123',
            birthDate: DateTime.now()
                .subtract(
                    Duration(days: 365 * 25)) //date before 25 years from now
                .toLocal()
                .toString()
                .split(' ')[0],
          ));
  final _currentUserRepository = Injector().currentUsersRepository;
  final _otherUsersRepository = Injector().otherUsersRepository;
  WidgetsFlutterBinding.ensureInitialized();
  SocketService _socket = SocketService();

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
    test('search for a specific user to follow', () {
      const searchText = 'testing dummy2 user';
      const resultUsersCount = 10;
      _otherUsersRepository
          .searchForUsers(searchText)
          .listen(expectAsync1((usersList) {
        _testingUsersList = _testingUsersList.map((testUser) {
          var user = usersList
              .singleWhere((element) => element.userName == testUser.userName);
          testUser.userID = user.userID;
          return testUser;
        }).toList();
        expect(usersList.length, resultUsersCount);
      }));
    });
    test('follow', () {
      var targetUser = _testingUsersList[5];
      _currentUserRepository
          .follow(
              CurrentUser().userID, targetUser.userID, CurrentUser().getRank())
          .listen(expectAsync1((_) {
        Future.delayed(Duration(seconds: 3)).then(expectAsync1((_) {
          expect(
              CurrentUser().followingRankedMap.containsValue(targetUser.userID),
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
          print(CurrentUser().followingRankedMap);
          expect(
              CurrentUser().followingRankedMap.containsValue(targetUser.userID),
              false);
        }));
      }));
    });
  });
  /* group('upload post: ', () {
    test('send new post', () {
      Post newPost = Post(
        userID: CurrentUser().userID,
        postContent: 'hello this my first post on "Post"',
        timestamp: DateTime.now().millisecondsSinceEpoch,
      );
      socket.sendPost(newPost);
    });
  }); */

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
