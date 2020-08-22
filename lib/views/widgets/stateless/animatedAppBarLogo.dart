import 'package:flutter/material.dart';
import 'package:post/style/appColors.dart';
import 'package:post/utils/sizeConfig.dart';

class AnimatedAppBarLogo extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize:
          Size(SizeConfig.screenWidth, SizeConfig.safeBlockVertical * 25),
      child: Hero(
        tag: 'logo',
        child: Material(
          type: MaterialType.transparency,
          child: AnimatedContainer(
            padding: EdgeInsets.fromLTRB(
              SizeConfig.safeBlockHorizontal * 10,
              SizeConfig.longScreen
                  ? SizeConfig.safeBlockVertical * 8
                  : SizeConfig.safeBlockVertical * 9,
              SizeConfig.safeBlockHorizontal * 10,
              SizeConfig.longScreen
                  ? SizeConfig.safeBlockVertical * 2.5
                  : SizeConfig.safeBlockVertical * 4,
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [AppColors.PRIMARY_COLOR, AppColors.SECONDARY_COLOR],
                ),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.elliptical(180, 40))),
            child: Image.asset(
              "lib/assets/post_logo_without_background.png",
            ),
            duration: Duration(milliseconds: 300),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100.0);
}
