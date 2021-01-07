import 'package:post/models/user.dart';
import 'package:post/repositories/abstract/currentUserRepository.dart';

class CurrentUserRepositoryLocalImpl implements CurrentUserRepository {
  @override
  Stream<void> alternateLogin(User user) {
    // TODO: implement alternateLogin
  }

  @override
  Stream<String> deleteAccount(String email) {
    // TODO: implement deleteAccount
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Stream<void> follow(String currentUserID, String targetUserID, int rank) {
    // TODO: implement follow
  }

  @override
  Stream<void> login(String email, String password) {
    // TODO: implement login
  }

  @override
  Stream<void> logout() {
    // TODO: implement logout
  }

  @override
  Stream<void> singup(User user) {
    // TODO: implement singup
  }

  @override
  Stream<void> unFollow(String currentUserID, String targetUserID, int rank) {
    // TODO: implement unFollow
  }

  @override
  Stream<String> updateProfileData(String newUserName, String newBio) {
    // TODO: implement updateProfileData
  }

  @override
  Stream<String> updateRank(
      String currentUserID, String targetUserID, int oldRank, int newRank) {
    // TODO: implement updateRank
  }

  @override
  Stream<void> uploadProfilePic(Map<String, String> imageMap) {
    // TODO: implement uploadProfilePic
  }
}
