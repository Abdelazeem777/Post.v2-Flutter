import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:post/di/injection.dart';
import 'package:post/models/enums/postTypeEnum.dart';
import 'package:post/models/post.dart';
import 'package:post/models/user.dart';
import 'package:post/services/currentUser.dart';
import 'package:post/services/socketService.dart';

main() {
  initHive();
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
  final _currentUserRepository = Injector().currentUserRepository;
  final _otherUsersRepository = Injector().otherUsersRepository;
  final _postsRepository = Injector().postsRepository;
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
    test('search for a specific user to follow', () async {
      const searchText = 'testing dummy2 user';
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
          expect(CurrentUser().followingRankedList.contains(targetUser.userID),
              false);
        }));
      }));
    });
  });
  group('upload post: ', () {
    Post newPost = Post(
      postType: PostType.Text,
      postContent: 'hello this my first post on "Post"',
      timestamp: DateTime.now().millisecondsSinceEpoch,
      userID: null, //still need to initialized
    );

    test('send new post', () {
      newPost.userID = CurrentUser().userID;
      _postsRepository.uploadNewPost(newPost).listen(expectAsync1((_) {
        _postsRepository
            .getCurrentUserPosts()
            .listen(expectAsync1((comingPost) {
          expect(comingPost.postContent, newPost.postContent);
          expect(comingPost.userID, newPost.userID);
          newPost.postID = comingPost.postID;
        }));
      }));
    });

    test('delete post', () {
      final postID = newPost.postID;
      final userID = newPost.userID;
      final userPassword = 'TestingUser123';
      _postsRepository.deletePost(postID, userID, userPassword).listen(
          expectAsync1(
              (result) => expect(result, 'Post is deleted successfully')));
    });
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
