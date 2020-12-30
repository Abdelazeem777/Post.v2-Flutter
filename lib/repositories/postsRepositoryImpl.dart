import 'dart:async';

import 'package:post/di/injection.dart';
import 'package:post/models/post.dart';
import 'abstract/postsRepository.dart';

class PostsRepositoryImpl implements PostsRepository {
  PostsRepository _remote;
  PostsRepositoryImpl() {
    _remote = Injector().postsRepositoryRemote;
  }

  @override
  Stream<Post> getCurrentUserPosts() {
    return _remote.getCurrentUserPosts();
  }

  @override
  Stream<Post> getFollowingUsersPosts(List<String> usersIDsList) {
    return _remote.getFollowingUsersPosts(usersIDsList);
  }

  @override
  Stream<void> uploadNewPost(Post newPost) {
    return _remote.uploadNewPost(newPost);
  }

  @override
  Stream<String> deletePost(String postID, String userID, String userPassword) {
    return _remote.deletePost(postID, userID, userPassword);
  }

  @override
  void dispose() {
    _remote.dispose();
  }
}
