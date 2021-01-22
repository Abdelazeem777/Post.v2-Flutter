import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:post/di/injection.dart';
import 'package:post/services/connectionChecker.dart';
import 'package:post/utils/notificationUtils/notificationIDHelper.dart';

import 'views/editPofilePage/editProfilePageView.dart';
import 'views/followingRankedListPage/followingRankedListPageView.dart';
import 'views/newPostPage/newPostPageView.dart';
import 'views/notificationsPage/noificationsPageView.dart';
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
    _initHive();
    _initLocalNotification();
    ConnectionChecker().initialize();
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

  Future<void> _initHive() async {
    var hiveHelper = Injector().hiveHelper;
    await hiveHelper.initHive();
  }

  void _initLocalNotification() {
    var flutterLocalNotificationPlugin =
        Injector().flutterLocalNotificationPlugin;
    flutterLocalNotificationPlugin.init(context);
  }

  @override
  Future<void> dispose() async {
    var hiveHelper = Injector().hiveHelper;
    await hiveHelper.closeHive();
    ConnectionChecker().dispose();
    await NotificationIDHelper().dispose();
    super.dispose();
  }
}
