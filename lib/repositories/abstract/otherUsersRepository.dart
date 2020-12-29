import 'package:post/models/user.dart';

abstract class OtherUsersRepository {
  Stream<List<User>> searchForUsers(String userName);
  Stream<List<User>> loadFollowingList(String userID);
  Stream<List<User>> loadFollowersList(String userID);
  void dispose();
}
