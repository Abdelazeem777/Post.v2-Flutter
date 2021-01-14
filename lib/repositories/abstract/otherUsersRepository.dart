import 'package:post/models/user.dart';

abstract class OtherUsersRepository {
  Stream<User> searchForUsers(String userName);
  Stream<User> loadFollowingUsers(String userID);
  Stream<User> loadFollowersUsers(String userID);
  void dispose();
}
