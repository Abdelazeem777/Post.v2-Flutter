import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:post/services/facebookLoginHelper.dart';
import 'package:post/services/googleLoginHelper.dart';
import 'package:post/utils/sizeConfig.dart';

class SocialMediaLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            iconSize: SizeConfig.safeBlockVertical * 8,
            icon: Icon(
              FontAwesomeIcons.facebook,
              color: Color(0xff4267B2),
            ),
            onPressed: FaceBookLoginHelper.login),
        Container(
          height: SizeConfig.safeBlockVertical * 8,
          width: SizeConfig.safeBlockVertical * 8,
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: InkWell(
              child: Image.asset(
                "lib/assets/google_icon.png",
              ),
              onTap: GoogleLoginHelper.login),
        )
      ],
    );
  }
}
