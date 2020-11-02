import 'package:enum_to_string/enum_to_string.dart';
import 'package:post/enums/postTypeEnum.dart';
import 'react.dart';
import 'comment.dart';

class Post {
  String postID;
  String userID;
  String postContent;
  PostType postType;
  int timestamp;
  List<React> reactsList;
  int numberOfShares;
  List<Comment> commentsList;

  Post({
    this.postID,
    this.userID,
    this.postContent,
    this.postType = PostType.Text,
    this.timestamp,
    this.reactsList = const [],
    this.numberOfShares = 0,
    this.commentsList = const [],
  });

  Post.fromJson(Map<String, dynamic> json) {
    postID = json['postID'];
    userID = json['userID'];
    postContent = json['postContent'];
    postType = EnumToString.fromString(PostType.values, json['postType']);
    timestamp = json['timestamp'];
    if (json['reactsList'] != null) {
      reactsList = new List<React>();
      json['reactsList'].forEach((v) {
        reactsList.add(new React.fromJson(v));
      });
    }
    numberOfShares = json['numberOfShares'];
    if (json['commentsList'] != null) {
      commentsList = new List<Comment>();
      json['commentsList'].forEach((v) {
        commentsList.add(new Comment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postID'] = this.postID;
    data['userID'] = this.userID;
    data['postContent'] = this.postContent;
    data['postType'] = EnumToString.parse(this.postType);
    data['timestamp'] = this.timestamp;
    if (this.reactsList != null) {
      data['reactsList'] = this.reactsList.map((v) => v.toJson()).toList();
    }
    data['numberOfShares'] = this.numberOfShares;
    if (this.commentsList != null) {
      data['commentsList'] = this.commentsList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
