import 'dart:async';

import 'package:post/apiEndpoint.dart';
import 'package:post/di/injection.dart';
import 'package:post/models/post.dart';
import 'package:post/services/currentUser.dart';
import 'package:post/services/socketService.dart';
import 'package:post/utils/requestException.dart';
import 'package:rxdart/rxdart.dart';

abstract class PostsRepository {
  Stream<void> uploadNewPost(Post newPost);
  Stream<Post> getFollowingUsersPosts();
  Stream<Post> getCurrentUserPosts();

  Stream<String> deletePost(String postID, String userID, String userPassword);
}

class PostsRepositoryImpl implements PostsRepository {
  final _networkService = Injector().networkService;
  var _followingUsersPostsStreamController = StreamController<Post>();
  var _currentUserPostsStreamController = StreamController<Post>();
  SocketService _socketService;
  PostsRepositoryImpl() {
    _socketService = SocketService()..onNewPost = this._onNewPost;
  }

  @override
  Stream<void> uploadNewPost(Post newPost) {
    return Stream.fromFuture(_socketService.uploadNewPost(newPost));
  }

  @override
  Stream<Post> getFollowingUsersPosts() {
    var _newPostsStream = _followingUsersPostsStreamController.stream;
    return _newPostsStream;
  }

//TODO: return creates a new stream from that stream which is not listening to any changes happen
  @override
  Stream<Post> getCurrentUserPosts() {
    var _postsStream = _currentUserPostsStreamController.stream;

    return _postsStream;
  }

//TODO: use this condition when u trying to add posts from db
  bool hasNewPosts(Stream<Post> _newPostsStream) =>
      _newPostsStream.length != Future.value(0);

  void _onNewPost(newPostMap) {
    final newPost = Post.fromMap(newPostMap);
    print("bido" + newPostMap.toString());
    if (newPost.userID == CurrentUser().userID) {
      _currentUserPostsStreamController.add(newPost);

      CurrentUser()
        ..postsList.add(newPost.postID)
        ..saveUserToPreference().listen((_) {})
        ..notify();
    } else
      _followingUsersPostsStreamController.add(newPost);
  }

  @override
  Stream<String> deletePost(String postID, String userID, String userPassword) {
    final data = {
      'postID': postID,
      'userID': userID,
      'userPassword': userPassword
    };
    final dataJson = _networkService.convertMapToJson(data);
    return Stream.fromFuture(
            _networkService.post(ApiEndPoint.DELETE_POST, dataJson))
        .map((response) {
      if (response.statusCode != 200 || null == response.statusCode) {
        Map responseMap = _networkService.convertJsonToMap(response.body);
        throw new RequestException(responseMap["message"]);
      } else {
        CurrentUser()
          ..postsList.remove(postID)
          ..saveUserToPreference().listen((_) {})
          ..notify();
        return response.body.toString();
      }
    });
  }

  dispose() {
    _currentUserPostsStreamController.close();
    _followingUsersPostsStreamController.close();
  }
}
