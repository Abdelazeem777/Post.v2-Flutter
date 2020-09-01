class User {
  int userID;
  String userName;
  String bio;
  bool following;
  String userProfilePicURL;
  bool active;
  List<int> followersList;
  List<int> followingList;
  List<int> postsList;

  User(
      {this.userID,
      this.userName,
      this.bio,
      this.following,
      this.userProfilePicURL,
      this.active,
      this.followersList,
      this.followingList,
      this.postsList});

  User.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    userName = json['userName'];
    bio = json['bio'];
    following = json['following'];
    userProfilePicURL = json['userProfilePicURLl'];
    active = json['active'];
    followersList = json['followersList'].cast<int>();
    followingList = json['followingList'].cast<int>();
    postsList = json['postsList'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['userName'] = this.userName;
    data['bio'] = this.bio;
    data['following'] = this.following;
    data['userProfilePicURL'] = this.userProfilePicURL;
    data['active'] = this.active;
    data['followersList'] = this.followersList;
    data['followingList'] = this.followingList;
    data['postsList'] = this.postsList;
    return data;
  }
}
