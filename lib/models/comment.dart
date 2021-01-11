import 'package:enum_to_string/enum_to_string.dart';
import 'package:post/models/enums/commentTypeEnum.dart';

import 'react.dart';
import 'reply.dart';

class Comment {
  String commentID;
  String userID;
  String commentContent;
  CommentType commentType;
  int timestamp;
  List<React> reactsList;
  List<Reply> repliesList;

  Comment({
    this.commentID,
    this.userID,
    this.commentContent,
    this.commentType,
    this.timestamp,
    this.reactsList = const [],
    this.repliesList = const [],
  });

  Comment.fromMap(Map<String, dynamic> map) {
    commentID = map['commentID'];
    userID = map['userID'];
    commentContent = map['commentContent'];
    commentType =
        EnumToString.fromString(CommentType.values, map['commentType']);
    timestamp = map['timestamp'];
    if (map['reactsList'] != null) {
      reactsList = new List<React>();
      map['reactsList'].forEach((v) {
        reactsList.add(new React.fromMap(v));
      });
    }
    if (map['repliesList'] != null) {
      repliesList = new List<Reply>();
      map['repliesList'].forEach((v) {
        repliesList.add(new Reply.fromMap(v));
      });
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentID'] = this.commentID;
    data['userID'] = this.userID;
    data['commentContent'] = this.commentContent;
    data['commentType'] = EnumToString.convertToString(this.commentType);
    data['timestamp'] = this.timestamp;
    if (this.reactsList != null) {
      data['reactsList'] = this.reactsList.map((v) => v.toMap()).toList();
    }
    if (this.repliesList != null) {
      data['repliesList'] = this.repliesList.map((v) => v.toMap()).toList();
    }
    return data;
  }
}
