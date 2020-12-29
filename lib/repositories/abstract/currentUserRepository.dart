import 'package:post/models/user.dart';

abstract class CurrentUserRepository {
  Stream<void> login(String email, String password);
  Stream<void> singup(User user);
  Stream<void> alternateLogin(User user);
  Stream<String> deleteAccount(String email);
  Stream<void> logout();
  Stream<void> uploadProfilePic(Map<String, String> imageMap);
  Stream<String> updateProfileData(String newUserName, String newBio);
  Stream<void> follow(String currentUserID, String targetUserID, int rank);
  Stream<void> unFollow(String currentUserID, String targetUserID, int rank);
  Stream<String> updateRank(
      String currentUserID, String targetUserID, int oldRank, int newRank);

  void dispose();
}
