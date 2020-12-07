import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:post/di/injection.dart';
import 'package:post/enums/postTypeEnum.dart';
import 'package:post/models/post.dart';
import 'package:post/models/user.dart';
import 'package:post/services/currentUser.dart';
import 'package:post/services/socketService.dart';

main() {
  final _currentUserRepository = Injector().currentUserRepository;
  final _otherUsersRepository = Injector().otherUsersRepository;
  final _postsRepository = Injector().postsRepository;
  SocketService _socket = SocketService();
  WidgetsFlutterBinding.ensureInitialized();

  group('Get currentUser\'s posts:', () {
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
    var _newPostsList = List<Post>.generate(
        3,
        (index) => Post(
              postType: PostType.Text,
              postContent: 'this is a new testing post',
              timestamp: DateTime.now().millisecondsSinceEpoch,
              userID: null, //still need to initialized
            ));
    var _postsResultList = List<Post>();
    test('Signup with valid inputs', () {
      expect(
          () => _currentUserRepository
              .singup(_testingUser)
              .listen(expectAsync1((_) {})),
          returnsNormally);
    });

    test('connect to socket', () {
      expect(_socket.connect, returnsNormally);
    });

    test('send new posts', () {
      _newPostsList.forEach((newPost) {
        newPost.userID = CurrentUser().userID;
        expect(() {
          _postsRepository.uploadNewPost(newPost).listen(expectAsync1((_) {}));
        }, returnsNormally);
      });
    });

    test('get all posts', () {
      int _currentUserPostsOnServerLength = _newPostsList.length;
      _postsRepository.getCurrentUserPosts().listen((comingPost) {
        _postsResultList.add(comingPost);
      }).onDone(() =>
          expect(_postsResultList.length, _currentUserPostsOnServerLength));
    });
    test('delete post', () {
      _postsResultList.forEach((post) {
        final postID = post.postID;
        final userID = post.userID;
        final userPassword = 'TestingUser123';
        _postsRepository.deletePost(postID, userID, userPassword).listen(
            expectAsync1(
                (result) => expect(result, 'Post is deleted successfully')));
      });
    });
    test('Delete CurrentUser account', () {
      _currentUserRepository
          .deleteAccount(_testingUser.email)
          .listen(expectAsync1((res) {
        expect(res, 'Deleted successfully');
      }));
    });
  });

  test('disconnect socket connection', () {
    expect(() => _socket.disconnect(), returnsNormally);
  });
}
