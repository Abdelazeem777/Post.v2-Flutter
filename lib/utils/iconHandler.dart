import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:post/enums/notificationTypeEnum.dart';
import 'package:post/enums/reactTypeEnum.dart';
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

  static Icon getReactIcon(ReactType reactType, {double size = 21.0}) {
    switch (reactType) {
      case ReactType.Like:
        return Icon(
          FontAwesomeIcons.solidThumbsUp,
          color: AppColors.SECONDARY_COLOR,
          size: size,
        );
        break;
      case ReactType.Love:
        return Icon(
          FontAwesomeIcons.solidHeart,
          color: Colors.red,
          size: size,
        );
        break;
      case ReactType.Haha:
        return Icon(
          FontAwesomeIcons.solidGrinSquint,
          color: Colors.yellow,
          size: size,
        );
        break;
      case ReactType.Sad:
        return Icon(
          FontAwesomeIcons.solidSadTear,
          color: Colors.yellow,
          size: size,
        );
        break;
      case ReactType.Angry:
        return Icon(
          FontAwesomeIcons.solidAngry,
          color: Colors.red[900],
          size: size,
        );
        break;
      case ReactType.none:
        return Icon(
          FontAwesomeIcons.thumbsUp,
          color: AppColors.SECONDARY_COLOR,
          size: size,
        );
        break;
      default:
        throw Exception("this reactType is not allowed");
        break;
    }
  }
}
