import 'package:flutter/foundation.dart';

class User {
  String userID;
  String userName;
  String phoneNumber;
  String birthDate;
  String bio;
  bool following; //TODO: remove following
  String userProfilePicURL;
  bool active;
  String email;
  String password;
  String accessToken;
  List<int> followersList;
  List<int> followingList;
  List<int> rankedUsersList;
  List<int> postsList;

  User({
    this.userID,
    this.userName,
    this.phoneNumber,
    this.birthDate,
    this.bio = "hey I am using Post app",
    this.following,
    this.userProfilePicURL = "Default",
    this.active = false,
    this.email,
    this.password,
    this.accessToken,
    this.followersList = const [],
    this.followingList = const [],
    this.rankedUsersList = const [],
    this.postsList = const [],
  });

  User.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    userName = json['userName'];
    phoneNumber = json['phoneNumber'];
    birthDate = json['birthDate'];
    bio = json['bio'];
    following = json['following'];
    userProfilePicURL = json['userProfilePicURL'];
    active = json['active'];
    email = json['email'];
    password = json['password'];
    accessToken = json['accessToken'];
    followersList = json['followersList']?.cast<int>();
    followingList = json['followingList']?.cast<int>();
    rankedUsersList = json['rankedUsersList']?.cast<int>();
    postsList = json['postsList']?.cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID ?? null;
    data['userName'] = this.userName;
    data['phoneNumber'] = this.phoneNumber;
    data['birthDate'] = this.birthDate;
    data['bio'] = this.bio;
    data['following'] = this.following;
    data['userProfilePicURL'] = this.userProfilePicURL;
    data['active'] = this.active;
    data['email'] = this.email;
    data['password'] = this.password;
    data['accessToken'] = this.accessToken;
    data['followersList'] = this.followersList;
    data['followingList'] = this.followingList;
    data['rankedUserList'] = this.rankedUsersList;
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
        o.following == following &&
        o.userProfilePicURL == userProfilePicURL &&
        o.active == active &&
        o.email == email &&
        o.password == password &&
        o.accessToken == accessToken &&
        listEquals(o.followersList, followersList) &&
        listEquals(o.followingList, followingList) &&
        listEquals(o.rankedUsersList, rankedUsersList) &&
        listEquals(o.postsList, postsList);
  }

  @override
  int get hashCode {
    return userID.hashCode ^
        userName.hashCode ^
        phoneNumber.hashCode ^
        birthDate.hashCode ^
        bio.hashCode ^
        following.hashCode ^
        userProfilePicURL.hashCode ^
        active.hashCode ^
        email.hashCode ^
        password.hashCode ^
        accessToken.hashCode ^
        followersList.hashCode ^
        followingList.hashCode ^
        rankedUsersList.hashCode ^
        postsList.hashCode;
  }

  @override
  String toString() {
    return 'User(userID: $userID, userName: $userName, phoneNumber: $phoneNumber, birthDate: $birthDate, bio: $bio, following: $following, userProfilePicURL: $userProfilePicURL, active: $active, email: $email, password: $password, accessToken: $accessToken, followersList: $followersList, followingList: $followingList, rankedUsersList: $rankedUsersList, postsList: $postsList)';
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
    List<int> followersList,
    List<int> followingList,
    List<int> rankedUsersList,
    List<int> postsList,
  }) {
    return User(
      userID: userID ?? this.userID,
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      birthDate: birthDate ?? this.birthDate,
      bio: bio ?? this.bio,
      following: following ?? this.following,
      userProfilePicURL: userProfilePicURL ?? this.userProfilePicURL,
      active: active ?? this.active,
      email: email ?? this.email,
      password: password ?? this.password,
      accessToken: accessToken ?? this.accessToken,
      followersList: followersList ?? this.followersList,
      followingList: followingList ?? this.followingList,
      rankedUsersList: rankedUsersList ?? this.rankedUsersList,
      postsList: postsList ?? this.postsList,
    );
  }
}
