import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:post/views/editPofilePage/editProfilePageViewModel.dart';
import 'package:post/views/newPostPage/newPostPageView.dart';
import 'package:post/views/notificationsPage/noificationsPageView.dart';

import 'views/home/homeView.dart';
import 'views/login/loginView.dart';
import 'views/signUp/signUpView.dart';
import 'views/splashScreen/splashScreenView.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
        .copyWith(systemNavigationBarColor: Colors.white));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Post",
      routes: <String, WidgetBuilder>{
        EditProfilePage.routeName: (BuildContext context) {
          return EditProfilePage();
        },
        Notifications.routeName: (BuildContext context) {
          return Notifications();
        },
        NewPost.routeName: (BuildContext context) {
          return NewPost();
        },
        Home.routeName: (BuildContext context) {
          return Home();
        },
        Login.routeName: (BuildContext context) {
          return Login();
        },
        SignUp.routeName: (BuildContext context) {
          return SignUp();
        },
        SplashScreen.routeName: (BuildContext context) {
          return SplashScreen();
        }
      },
      home: SplashScreen(),
    );
  }
}
