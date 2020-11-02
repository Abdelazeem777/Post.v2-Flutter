import 'package:flutter_test/flutter_test.dart';
import 'package:post/di/injection.dart';
import 'package:post/models/post.dart';
import 'package:post/services/currentUser.dart';
import 'package:post/services/socketService.dart';

//TODO: I am gonna postpone working on this feature till finishing the "following" feature
main() {
  group('upload post: ', () {
    SocketService socket = Injector().socketService;
    test('connect to socket', () {
      expect(socket.createSocketConnection, returnsNormally);
    });
    test('send new post', () {
      Post newPost = Post(
        userID: CurrentUser().userID,
        postContent: 'hello this my first post on "Post"',
        timestamp: DateTime.now().millisecondsSinceEpoch,
      );
      socket.sendPost(newPost);
    });
  });
}
