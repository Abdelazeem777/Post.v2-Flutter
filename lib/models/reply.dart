import 'package:enum_to_string/enum_to_string.dart';
import 'package:post/models/enums/replyTypeEnum.dart';

import 'react.dart';

class Reply {
  String replyID;
  String userID;
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

  Reply.fromMap(Map<String, dynamic> map) {
    replyID = map['replyID'];
    userID = map['userID'];
    replyContent = map['replyContent'];
    replyType = EnumToString.fromString(ReplyType.values, map['replyType']);
    timestamp = map['timestamp'];
    if (map['reactsList'] != null) {
      reactsList = new List<React>();
      map['reactsList'].forEach((v) {
        reactsList.add(new React.fromMap(v));
      });
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['replyID'] = this.replyID;
    data['userID'] = this.userID;
    data['replyContent'] = this.replyContent;
    data['replyType'] = EnumToString.convertToString(this.replyType);
    data['timestamp'] = this.timestamp;
    if (this.reactsList != null) {
      data['reactsList'] = this.reactsList.map((v) => v.toMap()).toList();
    }
    return data;
  }
}
