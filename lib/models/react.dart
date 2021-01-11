import 'package:enum_to_string/enum_to_string.dart';
import 'package:post/models/enums/reactTypeEnum.dart';

class React {
  String userID;
  ReactType reactType;

  React({this.userID, this.reactType});

  React.fromMap(Map<String, dynamic> map) {
    userID = map['userID'];
    reactType = EnumToString.fromString(ReactType.values, map['reactType']);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['reactType'] = EnumToString.convertToString(this.reactType);
    return data;
  }
}
