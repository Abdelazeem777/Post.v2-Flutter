import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:post/di/injection.dart';
import 'package:post/services/alternativeLoginHandler.dart';
import 'package:post/utils/sizeConfig.dart';
import 'package:post/views/home/homeView.dart';

class SocialMediaLogin extends StatelessWidget {
  BuildContext context;
  SocialMediaLogin({Key key, @required this.context}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [buildFacebookLoginButton(), buildGoogleLoginButton()],
    );
  }

  Container buildGoogleLoginButton() {
    AlternateLoginHandler _loginHandler = Injector().googleLoginHandler;
    return Container(
      height: SizeConfig.safeBlockVertical * 8,
      width: SizeConfig.safeBlockVertical * 8,
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: InkWell(
        child: Image.asset(
          "lib/assets/google_icon.png",
        ),
        onTap: () => _loginHandler.login(onLoginSuccess: _goToHomePage),
      ),
    );
  }

  IconButton buildFacebookLoginButton() {
    AlternateLoginHandler _loginHandler = Injector().facebookLoginHandler;
    return IconButton(
      iconSize: SizeConfig.safeBlockVertical * 8,
      icon: Icon(
        FontAwesomeIcons.facebook,
        color: Color(0xff4267B2),
      ),
      onPressed: () => _loginHandler.login(onLoginSuccess: _goToHomePage),
    );
  }

  void _goToHomePage() => Navigator.of(context).popAndPushNamed(Home.routeName);
}
