import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:post/views/editPofilePage/editProfilePageView.dart';
import 'package:post/views/followingRankedListPage/followingRankedListPageView.dart';
import 'package:post/views/newPostPage/newPostPageView.dart';
import 'package:post/views/notificationsPage/noificationsPageView.dart';

import 'views/followersListPage/followersListPageView.dart';
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
        FollowersListPage.routeName: (context) => FollowersListPage(),
        FollowingRankedListPage.routeName: (context) =>
            FollowingRankedListPage(),
        EditProfilePage.routeName: (context) => EditProfilePage(),
        Notifications.routeName: (context) => Notifications(),
        NewPost.routeName: (context) => NewPost(),
        Home.routeName: (context) => Home(),
        Login.routeName: (context) => Login(),
        SignUp.routeName: (context) => SignUp(),
        SplashScreen.routeName: (context) => SplashScreen()
      },
      home: SplashScreen(),
    );
  }
}
