import 'package:enum_to_string/enum_to_string.dart';
import 'package:post/enums/replyTypeEnum.dart';

import 'react.dart';

class Reply {
  int replyID;
  int userID;
  String replyContent;
  ReplyType replyType;
  int timestamp;
  List<React> reactsList;

  Reply(
      {this.replyID,
      this.userID,
      this.replyContent,
      this.replyType,
      this.timestamp,
      this.reactsList});

  Reply.fromJson(Map<String, dynamic> json) {
    replyID = json['replyID'];
    userID = json['userID'];
    replyContent = json['replyContent'];
    replyType = EnumToString.fromString(ReplyType.values, json['replyType']);
    timestamp = json['timestamp'];
    if (json['reactsList'] != null) {
      reactsList = new List<React>();
      json['reactsList'].forEach((v) {
        reactsList.add(new React.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['replyID'] = this.replyID;
    data['userID'] = this.userID;
    data['replyContent'] = this.replyContent;
    data['replyType'] = EnumToString.parse(this.replyType);
    data['timestamp'] = this.timestamp;
    if (this.reactsList != null) {
      data['reactsList'] = this.reactsList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
