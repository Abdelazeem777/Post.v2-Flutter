import 'package:hive/hive.dart';
import 'package:post/di/injection.dart';
import 'package:post/models/post.dart';
import 'package:post/repositories/abstract/baseLocalRepository.dart';
import 'package:post/repositories/abstract/postsRepository.dart';
import 'package:post/repositories/concrete/Local/hiveBoxsConstants.dart';
import 'package:post/services/abstract/hiveHelper.dart';
import 'package:post/services/currentUser.dart';

class PostsRepositoryLocalImpl implements BaseLocalRepository, PostsRepository {
  LazyBox<Map> _postsBox;
  final _hiveHelper = Injector().hiveHelper;

  @override
  Stream<Post> getCurrentUserPosts() async* {
    _postsBox = await _hiveHelper.getLazyBox(POSTS_BOX);
    final currentUserPostsID = CurrentUser().postsList;
    for (var postID in currentUserPostsID) {
      var postMap = await _postsBox.get(postID);
      if (postMap == null) continue;
      postMap = Map<String, dynamic>.from(postMap);
      final post = Post.fromMap(postMap);
      yield post;
    }
  }

  @override
  Stream<Post> getFollowingUsersPosts(List<String> usersIDsList) async* {
    var usersBox = await _hiveHelper.getLazyBox(USERS_BOX);
    _postsBox = await _hiveHelper.getLazyBox(POSTS_BOX);
    await for (var postsIDsList in _getPostsIDs(usersBox, usersIDsList)) {
      yield* _getPostByPostID(postsIDsList);
    }
  }

  Stream<List> _getPostsIDs(
      LazyBox usersBox, List<String> usersIDsList) async* {
    for (var userID in usersIDsList) {
      final userMap = await usersBox.get(userID) as Map;
      if (userMap == null) continue;
      final postsList = userMap['postsList'] as List;
      if (postsList == null || postsList.isEmpty) continue;
      yield postsList;
    }
  }

  Stream<Post> _getPostByPostID(List postsIDsList) async* {
    for (var postID in postsIDsList) {
      var postMap = await _postsBox.get(postID);
      if (postMap == null) continue;
      postMap = Map<String, dynamic>.from(postMap);
      final post = Post.fromMap(postMap);
      yield post;
    }
  }

  @override
  Stream<void> updateLocalFromRemote(newPost) async* {
    _postsBox = await _hiveHelper.getLazyBox(POSTS_BOX);
    final postID = newPost['postID'];
    final userID = newPost['userID'];
    await _addPostToHiveBoxIfNotExist(postID, newPost);
    await _addPostID2UserPostIDsList(postID, userID);
  }

  Future _addPostToHiveBoxIfNotExist(String postID, newPost) async {
    if (!_postsBox.containsKey(postID)) await _postsBox.put(postID, newPost);
  }

  Future _addPostID2UserPostIDsList(String postID, String userID) async {
    final userBox = await _hiveHelper.getLazyBox(USERS_BOX);
    final userMap = await userBox.get(userID) as Map;
    if (userMap == null) return;
    final userPostIDList = userMap['postsList'];
    print(userPostIDList);
    if (userPostIDList == null)
      userMap.addAll({
        'postsList': [postID]
      });
    else if (!userPostIDList.contains(postID))
      userPostIDList.add(postID);
    else
      return;

    await userBox.put(userID, userMap);
  }

  @override
  Stream<String> deletePost(
      String postID, String userID, String userPassword) async* {
    _postsBox = await _hiveHelper.getLazyBox(POSTS_BOX);
    yield* Stream.fromFuture(_postsBox.delete(postID))
        .map((_) => 'Post is deleted successfully');
  }

  @override
  Stream<void> uploadNewPost(Post newPost) => throw UnimplementedError();

  @override
  Future<void> dispose() async {
    var result = await _hiveHelper.closeBox(POSTS_BOX);
    if (result)
      return;
    else
      throw Exception('Couldn\'t close the Users Hive box.');
  }
}
