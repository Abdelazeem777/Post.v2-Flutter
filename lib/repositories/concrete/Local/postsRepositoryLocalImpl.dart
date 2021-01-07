import 'package:hive/hive.dart';
import 'package:post/models/post.dart';
import 'package:post/repositories/abstract/postsRepository.dart';
import 'package:post/repositories/concrete/Local/hiveBoxsConstants.dart';
import 'package:post/services/currentUser.dart';

class PostsRepositoryLocalImpl implements PostsRepository {
  LazyBox<Map> _postsBox;

  @override
  Stream<Post> getCurrentUserPosts() async* {
    _postsBox = await Hive.openLazyBox(POSTS_BOX);
    final currentUserPostsID = CurrentUser().postsList;
    for (var postID in currentUserPostsID) {
      var postMap = await _postsBox.get(postID);
      if (postMap == null) continue;
      postMap = Map<String, dynamic>.from(postMap);
      final post = Post.fromMap(postMap);
      print(post);
      yield post;
    }
  }

  @override
  Stream<Post> getFollowingUsersPosts(List<String> usersIDsList) async* {}

  @override
  Stream<void> uploadNewPost(Post newPost) async* {
    _postsBox = await Hive.openLazyBox(POSTS_BOX);
    final postKey = newPost.postID;
    final postMap = newPost.toMap();
    print(postMap);
    await _postsBox.put(postKey, postMap);
  }

  @override
  Stream<String> deletePost(
      String postID, String userID, String userPassword) async* {
    _postsBox = await Hive.openLazyBox(POSTS_BOX);
    yield* Stream.fromFuture(_postsBox.delete(postID))
        .map((_) => 'Post is deleted successfully');
  }

  @override
  Future<void> dispose() async {
    await _postsBox.close();
  }
}
