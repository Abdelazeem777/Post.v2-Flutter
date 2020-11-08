import 'package:flutter/foundation.dart';
import 'package:post/apiEndpoint.dart';

class User {
  String userID;
  String userName;
  String phoneNumber;
  String birthDate;
  String bio;
  String userProfilePicURL;
  bool active;
  String email;
  String password;
  String accessToken;
  List<String> followersList;
  List<String> followingRankedList;
  List<String> postsList;

  User({
    this.userID,
    this.userName,
    this.phoneNumber,
    this.birthDate,
    this.bio = "hey I am using Post app",
    this.userProfilePicURL = "Default",
    this.active = false,
    this.email,
    this.password,
    this.accessToken,
    this.followersList = const [],
    this.followingRankedList = const [],
    this.postsList = const [],
  });

  User.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    userName = json['userName'];
    phoneNumber = json['phoneNumber'];
    birthDate = json['birthDate'];
    bio = json['bio'];
    userProfilePicURL = fixUserProfilePicURLIfNeeded(json['userProfilePicURL']);
    active = json['active'];
    email = json['email'];
    password = json['password'];
    accessToken = json['accessToken'];
    followersList = json['followersList']?.cast<String>();
    followingRankedList = json['followingRankedList']?.cast<String>();
    postsList = json['postsList']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID ?? null;
    data['userName'] = this.userName;
    data['phoneNumber'] = this.phoneNumber;
    data['birthDate'] = this.birthDate;
    data['bio'] = this.bio;
    data['userProfilePicURL'] = this.userProfilePicURL;
    data['active'] = this.active;
    data['email'] = this.email;
    data['password'] = this.password;
    data['accessToken'] = this.accessToken;
    data['followersList'] = this.followersList;
    data['followingRankedList'] = this.followingRankedList;
    data['postsList'] = this.postsList;
    return data..removeWhere((key, value) => key == null || value == null);
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is User &&
        o.userID == userID &&
        o.userName == userName &&
        o.phoneNumber == phoneNumber &&
        o.birthDate == birthDate &&
        o.bio == bio &&
        o.userProfilePicURL == userProfilePicURL &&
        o.active == active &&
        o.email == email &&
        o.password == password &&
        o.accessToken == accessToken &&
        listEquals(o.followersList, followersList) &&
        listEquals(o.followingRankedList, followingRankedList) &&
        listEquals(o.postsList, postsList);
  }

  @override
  int get hashCode {
    return userID.hashCode ^
        userName.hashCode ^
        phoneNumber.hashCode ^
        birthDate.hashCode ^
        bio.hashCode ^
        userProfilePicURL.hashCode ^
        active.hashCode ^
        email.hashCode ^
        password.hashCode ^
        accessToken.hashCode ^
        followersList.hashCode ^
        followingRankedList.hashCode ^
        postsList.hashCode;
  }

  @override
  String toString() {
    return 'User(userID: $userID, userName: $userName, phoneNumber: $phoneNumber, birthDate: $birthDate, bio: $bio, userProfilePicURL: $userProfilePicURL, active: $active, email: $email, password: $password, accessToken: $accessToken, followersList: $followersList, followingRankedList: $followingRankedList, postsList: $postsList)';
  }

  User copyWith({
    String userID,
    String userName,
    String phoneNumber,
    String birthDate,
    String bio,
    bool following,
    String userProfilePicURL,
    bool active,
    String email,
    String password,
    String accessToken,
    List<String> followersList,
    List<String> followingRankedList,
    List<String> postsList,
  }) {
    return User(
      userID: userID ?? this.userID,
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      birthDate: birthDate ?? this.birthDate,
      bio: bio ?? this.bio,
      userProfilePicURL: userProfilePicURL ?? this.userProfilePicURL,
      active: active ?? this.active,
      email: email ?? this.email,
      password: password ?? this.password,
      accessToken: accessToken ?? this.accessToken,
      followersList: followersList ?? this.followersList,
      followingRankedList: followingRankedList ?? this.followingRankedList,
      postsList: postsList ?? this.postsList,
    );
  }

  void clone(User user) {
    this.userID = user.userID ?? this.userID;
    this.userName = user.userName ?? this.userName;
    this.phoneNumber = user.phoneNumber ?? this.phoneNumber;
    this.birthDate = user.birthDate ?? this.birthDate;
    this.bio = user.bio ?? this.bio;
    this.userProfilePicURL = user.userProfilePicURL ?? this.userProfilePicURL;
    this.active = user.active ?? this.active;
    this.email = user.email ?? this.email;
    this.password = user.password ?? this.password;
    this.accessToken = user.accessToken ?? this.accessToken;
    this.followersList = user.followersList ?? this.followersList;
    this.followingRankedList =
        user.followingRankedList ?? this.followingRankedList;
    this.postsList = user.postsList ?? this.postsList;
  }

  ///before adding userProfilePic you need to pass it
  /// to this method to convert it to the correct format
  ///
  /// if it contains 'Default' or a facebook or google profile picture
  /// it will return it without changes but
  ///
  /// if not
  ///
  /// it will add 'http://' at the first of it
  String fixUserProfilePicURLIfNeeded(String profilePicURL) {
    return profilePicURL.toString().contains('Default') ||
            profilePicURL.toString().contains('http')
        ? profilePicURL
        : ApiEndPoint.REQUEST_URL + profilePicURL;
  }
}
