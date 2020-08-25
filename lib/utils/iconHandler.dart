import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:post/models/userNotification.dart';
import 'package:post/style/appColors.dart';

class IconHandler {
  static Icon getIcon(NotificationType notificationType, ReactType reactType) {
    switch (notificationType) {
      case NotificationType.Comment:
        return Icon(
          Icons.comment,
          color: AppColors.PRIMARY_COLOR,
        );
        break;
      case NotificationType.Follow:
        return Icon(
          Icons.person_add,
          color: AppColors.PRIMARY_COLOR,
        );
        break;
      case NotificationType.Share:
        return Icon(
          Icons.share,
          color: AppColors.PRIMARY_COLOR,
        );
        break;
      case NotificationType.React:
        return getReactIcon(reactType);
        break;
      default:
        throw Exception("undefined notification type");
        break;
    }
  }

  static Icon getReactIcon(ReactType reactType) {
    switch (reactType) {
      case ReactType.Like:
        return Icon(
          FontAwesomeIcons.solidThumbsUp,
          color: AppColors.SECONDARY_COLOR,
        );
        break;
      case ReactType.Love:
        return Icon(
          FontAwesomeIcons.solidHeart,
          color: Colors.red,
        );
        break;
      case ReactType.Happy:
        return Icon(
          FontAwesomeIcons.solidGrinSquint,
          color: Colors.yellow,
        );
        break;
      case ReactType.Sad:
        return Icon(
          FontAwesomeIcons.solidSadTear,
          color: Colors.yellow,
        );
        break;
      case ReactType.Angry:
        return Icon(
          FontAwesomeIcons.solidAngry,
          color: Colors.red[900],
        );
        break;
      default:
        throw Exception("this reactType is not allowed");
        break;
    }
  }
}
