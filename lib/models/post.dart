import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/foundation.dart';

import 'package:post/enums/postTypeEnum.dart';

import 'comment.dart';
import 'react.dart';

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
    @required this.userID,
    @required this.postContent,
    @required this.postType,
    @required this.timestamp,
    this.reactsList = const [],
    this.numberOfShares = 0,
    this.commentsList = const [],
  });

  Post.fromMap(Map<String, dynamic> json) {
    postID = json['postID'];
    userID = json['userID'];
    postContent = json['postContent'];
    postType = EnumToString.fromString(PostType.values, json['postType']);
    timestamp = json['timestamp'];
    if (json['reactsList'] != null) {
      reactsList = new List<React>();
      json['reactsList'].forEach((v) {
        reactsList.add(new React.fromMap(v));
      });
    }
    numberOfShares = json['numberOfShares'];
    if (json['commentsList'] != null) {
      commentsList = new List<Comment>();
      json['commentsList'].forEach((v) {
        commentsList.add(new Comment.fromMap(v));
      });
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'postID': postID,
      'userID': userID,
      'postContent': postContent,
      'postType': EnumToString.convertToString(postType),
      'timestamp': timestamp,
      'reactsList': reactsList?.map((x) => x?.toMap())?.toList(),
      'numberOfShares': numberOfShares,
      'commentsList': commentsList?.map((x) => x?.toMap())?.toList(),
    }..removeWhere((key, value) => key == null || value == null);
  }

  Post copyWith({
    String postID,
    String userID,
    String postContent,
    PostType postType,
    int timestamp,
    List<React> reactsList,
    int numberOfShares,
    List<Comment> commentsList,
  }) {
    return Post(
      postID: postID ?? this.postID,
      userID: userID ?? this.userID,
      postContent: postContent ?? this.postContent,
      postType: postType ?? this.postType,
      timestamp: timestamp ?? this.timestamp,
      reactsList: reactsList ?? this.reactsList,
      numberOfShares: numberOfShares ?? this.numberOfShares,
      commentsList: commentsList ?? this.commentsList,
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post(postID: $postID, userID: $userID, postContent: $postContent,postType: ${EnumToString.convertToString(postType)}, timestamp: $timestamp, reactsList: $reactsList, numberOfShares: $numberOfShares, commentsList: $commentsList)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Post &&
        o.postID == postID &&
        o.userID == userID &&
        o.postContent == postContent &&
        o.postType == postType &&
        o.timestamp == timestamp &&
        listEquals(o.reactsList, reactsList) &&
        o.numberOfShares == numberOfShares &&
        listEquals(o.commentsList, commentsList);
  }

  @override
  int get hashCode {
    return postID.hashCode ^
        userID.hashCode ^
        postContent.hashCode ^
        postType.hashCode ^
        timestamp.hashCode ^
        reactsList.hashCode ^
        numberOfShares.hashCode ^
        commentsList.hashCode;
  }
}
