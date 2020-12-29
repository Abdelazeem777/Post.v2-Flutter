import 'dart:async';

import 'package:post/apiEndpoint.dart';
import 'package:post/di/injection.dart';
import 'package:post/models/post.dart';
import 'package:post/repositories/abstract/postsRepository.dart';
import 'package:post/services/currentUser.dart';
import 'package:post/services/socketService.dart';
import 'package:post/utils/requestException.dart';
import 'package:rxdart/rxdart.dart';

class PostsRepositoryRemoteImpl implements PostsRepository {
  final _networkService = Injector().networkService;
  var _followingUsersPostsStreamController = StreamController<Post>.broadcast();
  var _currentUserPostsStreamController = StreamController<Post>.broadcast();
  SocketService _socketService;
  PostsRepositoryRemoteImpl() {
    _socketService = SocketService()..onNewPost = this._onNewPost;
  }

  @override
  Stream<Post> getCurrentUserPosts() {
    return _getPostsFromAPI(CurrentUser().userID)
        .concatWith([_currentUserPostsStreamController.stream]);
  }

  Stream<Post> _getPostsFromAPI(String userID) {
    String userIDParam = '/$userID';
    return Stream.fromFuture(
            _networkService.get(ApiEndPoint.GET_POSTS + userIDParam))
        .flatMap((response) {
      Map responseMap = _networkService.convertJsonToMap(response.body);
      if (response.statusCode != 200 || null == response.statusCode) {
        throw new RequestException(responseMap["message"]);
      } else {
        var postsListOfMap = responseMap['postsList'] as List;
        var apiPostsStream = _getPostsFromMapList(postsListOfMap);
        return apiPostsStream;
      }
    });
  }

  Stream<Post> _getPostsFromMapList(List postsListOfMap) async* {
    for (var postMap in postsListOfMap) {
      yield Post.fromMap(postMap);
    }
  }

  void _getCurrentUserPostFromDataBase() {
    //TODO: use this method when you add the database feature
  }

  @override
  Stream<Post> getFollowingUsersPosts(List<String> usersIDsList) {
    return _followingUsersPostsStreamController.stream.mergeWith(
      _createPostsStreamsFromUsersIDsList(usersIDsList),
    );
  }

  ///Used to get all followers posts from the API by creating streams for every usersID and load them
  Iterable<Stream<Post>> _createPostsStreamsFromUsersIDsList(
          List<String> usersIDsList) =>
      usersIDsList.map<Stream<Post>>((userID) => _getPostsFromAPI(userID));

  void _onNewPost(newPostMap) {
    final newPost = Post.fromMap(newPostMap);
    if (newPost.userID == CurrentUser().userID) {
      _addPostToCurrentUserPostsStream(newPost);
      _addPostIDToCurrentUserPostsList(newPost.postID);
    } else
      _followingUsersPostsStreamController.sink.add(newPost);
  }

  void _addPostIDToCurrentUserPostsList(String newPostID) {
    CurrentUser()
      ..postsList.add(newPostID)
      ..saveUserToPreference().listen((_) {})
      ..notify();
  }

  void _addPostToCurrentUserPostsStream(Post newPost) {
    _currentUserPostsStreamController.sink.add(newPost);
  }

  @override
  Stream<void> uploadNewPost(Post newPost) {
    return Stream.fromFuture(_socketService.uploadNewPost(newPost));
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

  @override
  void dispose() {
    _currentUserPostsStreamController.close();
    _followingUsersPostsStreamController.close();
  }
}
