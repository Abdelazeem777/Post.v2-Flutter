import 'package:post/enums/reactTypeEnum.dart';

class React {
  int userID;
  ReactType reactType;

  React({this.userID, this.reactType});

  React.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    reactType = json['reactType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['reactType'] = this.reactType;
    return data;
  }
}
