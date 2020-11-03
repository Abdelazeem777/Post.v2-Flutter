import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:post/di/injection.dart';
import 'package:post/models/user.dart';
import 'package:post/services/currentUser.dart';

main() {
  group('follow feature: ', () {
    //generate 10 dummy users for testing
    List<User> _testingUsersList = List.generate(
        10,
        (i) => User(
              userName: "testing dummy user${i + 1}",
              phoneNumber: '0111863106',
              email: 'testing_user${i + 1}@test.com',
              password: 'TestingUser123',
              birthDate: DateTime.now()
                  .subtract(
                      Duration(days: 365 * 25)) //date before 25 years from now
                  .toLocal()
                  .toString()
                  .split(' ')[0],
            ));
    final _userRepository = Injector().usersRepository;
    final _otherUsersRepository = Injector().otherUsersRepository;
    WidgetsFlutterBinding.ensureInitialized();

    test('sign up with multiple testing users', () {
      _testingUsersList.forEach((user) {
        expect(() => _userRepository.singup(user).listen(expectAsync1((_) {})),
            returnsNormally);
      });
    });
    test('search for a specific user to follow', () {
      const searchText = 'testing dummy user';
      const resultUsersCount = 10;
      _otherUsersRepository
          .searchForUsers(searchText)
          .listen(expectAsync1((usersList) {
        for (var i = 0; i < 10; i++) {
          _testingUsersList[i].userID = usersList[i].userID;
        }
        expect(usersList.length, resultUsersCount);
      }));
    });
    test('follow a user', () {
      var targetUser = _testingUsersList[5];
      _otherUsersRepository
          .follow(CurrentUser().userID, targetUser.userID)
          .listen(expectAsync1((response) {
        expect(response, 'Ok');
        expect(CurrentUser().followingRankedList.contains(targetUser.userID),
            true);
      }));
    });

    test('unfollow a user', () {
      var targetUser = _testingUsersList[5];
      _otherUsersRepository
          .unFollow(CurrentUser().userID, targetUser.userID)
          .listen(expectAsync1((response) {
        expect(response, 'Ok');
        expect(CurrentUser().followingRankedList.contains(targetUser.userID),
            false);
      }));
    });

    test('delete testing users', () {
      _testingUsersList.forEach((user) {
        _userRepository.deleteAccount(user.email).listen(expectAsync1((res) {
          expect(res, 'Deleted successfully');
        }));
      });
    });
  });
}
