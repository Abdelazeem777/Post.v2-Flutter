import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserProfilePicture extends StatefulWidget {
  String imageURL;
  bool active;
  UserProfilePicture({this.imageURL = "Default", this.active = false});
  @override
  _UserProfilePictureState createState() => _UserProfilePictureState();
}

class _UserProfilePictureState extends State<UserProfilePicture> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipOval(
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            useOldImageOnUrlChange: true,
            imageUrl: this.widget.imageURL,
            placeholder: (context, url) => Container(
              color: Colors.green[100],
              constraints: BoxConstraints.expand(),
              child: FittedBox(
                child: Icon(
                  Icons.person,
                  color: Theme.of(context).canvasColor,
                ),
              ),
            ),
          ),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    this.widget.active ? Colors.green[400] : Colors.transparent,
              ),
            ))
      ],
    );
  }
}
