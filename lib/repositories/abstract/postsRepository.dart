import 'package:post/models/post.dart';

abstract class PostsRepository {
  Stream<Post> getCurrentUserPosts();
  Stream<Post> getFollowingUsersPosts(List<String> usersIDsList);

  Stream<void> uploadNewPost(Post newPost);
  Stream<String> deletePost(String postID, String userID, String userPassword);

  void dispose();
}
