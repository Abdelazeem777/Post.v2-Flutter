import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/foundation.dart';

import 'package:post/models/enums/notificationTypeEnum.dart';
import 'package:post/models/enums/reactTypeEnum.dart';

class NotificationModel {
  String notificationID;
  String fromUserID;
  String notificationContent;
  NotificationType notificationType;
  ReactType reactType;
  int timestamp;
  bool seen;
  Map payload;

  NotificationModel({
    this.notificationID,
    this.fromUserID,
    this.notificationContent,
    this.notificationType,
    this.reactType,
    this.timestamp,
    this.seen = false,
    this.payload,
  });

  NotificationModel.fromMap(Map<String, dynamic> map) {
    notificationID = map['notificationID'];
    fromUserID = map['fromUserID'];
    notificationContent = map['notificationContent'];
    notificationType = EnumToString.fromString(
        NotificationType.values, map['notificationType']);
    reactType = map['reactType'];
    timestamp = map['timestamp'];
    seen = map['seen'];
    payload = map['payload'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notificationID'] = this.notificationID;
    data['fromUserID'] = this.fromUserID;
    data['notificationContent'] = this.notificationContent;
    data['notificationType'] =
        EnumToString.convertToString(this.notificationType);
    data['reactType'] = this.reactType;
    data['timestamp'] = this.timestamp;
    data['seen'] = this.seen;
    data['payload'] = this.payload;
    return data;
  }

  NotificationModel copyWith({
    int notificationID,
    int fromUserID,
    String fromUser,
    String fromUserProfilePicURL,
    String notificationContent,
    NotificationType notificationType,
    ReactType reactType,
    int timestamp,
    bool seen,
    Map payload,
  }) {
    return NotificationModel(
      notificationID: notificationID ?? this.notificationID,
      fromUserID: fromUserID ?? this.fromUserID,
      notificationContent: notificationContent ?? this.notificationContent,
      notificationType: notificationType ?? this.notificationType,
      reactType: reactType ?? this.reactType,
      timestamp: timestamp ?? this.timestamp,
      seen: seen ?? this.seen,
      payload: payload ?? this.payload,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotificationModel(notificationID: $notificationID, fromUserID: $fromUserID, notificationContent: $notificationContent, notificationType: $notificationType, reactType: $reactType, timestamp: $timestamp, seen: $seen, payload: $payload)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is NotificationModel &&
        o.notificationID == notificationID &&
        o.fromUserID == fromUserID &&
        o.notificationContent == notificationContent &&
        o.notificationType == notificationType &&
        o.reactType == reactType &&
        o.timestamp == timestamp &&
        o.seen == seen &&
        mapEquals(o.payload, payload);
  }

  @override
  int get hashCode {
    return notificationID.hashCode ^
        fromUserID.hashCode ^
        notificationContent.hashCode ^
        notificationType.hashCode ^
        reactType.hashCode ^
        timestamp.hashCode ^
        seen.hashCode ^
        payload.hashCode;
  }
}
