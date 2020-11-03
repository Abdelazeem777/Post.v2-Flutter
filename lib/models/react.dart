import 'package:enum_to_string/enum_to_string.dart';
import 'package:post/enums/reactTypeEnum.dart';

class React {
  String userID;
  ReactType reactType;

  React({this.userID, this.reactType});

  React.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    reactType = EnumToString.fromString(ReactType.values, json['reactType']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['reactType'] = EnumToString.parse(this.reactType);
    return data;
  }
}
