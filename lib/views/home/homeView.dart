import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:post/style/appColors.dart';
import 'package:post/utils/sizeConfig.dart';
import 'package:post/views/newPostPage/newPostPageView.dart';
import 'package:post/views/notificationsPage/noificationsPageView.dart';
import 'package:post/views/widgets/homePageTabs/homeTab.dart';
import 'package:post/views/widgets/homePageTabs/profileTab.dart';
import 'package:post/views/widgets/homePageTabs/searchTab.dart';

class Home extends StatefulWidget {
  static const String routeName = '/Home';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPage = 1;
  bool isVisible = true;
  Widget _createAppBar() {
    return PreferredSize(
        child: Hero(
            tag: 'logo',
            child: Material(
              type: MaterialType.transparency,
              child: ClipPath(
                clipper: _AppBarCustomClipPath(),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        AppColors.PRIMARY_COLOR,
                        AppColors.SECONDARY_COLOR
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        child: Image.asset(
                          "lib/assets/post_logo_without_background.png",
                          scale: 8,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: SizeConfig.safeBlockHorizontal * 25,
                          right: SizeConfig.safeBlockHorizontal,
                        ),
                        child: IconButton(
                            icon: Icon(
                              Icons.notifications,
                              color: Colors.white,
                              size: 24,
                            ),
                            onPressed: goToNotificationPage),
                      )
                    ],
                  ),
                ),
              ),
            )),
        preferredSize: Size(SizeConfig.screenWidth, 81));
  }

  Widget _createHomePage() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Center(
          child: <Widget>[
        SearchTab(),
        HomeTab(),
        ProfileTab(),
      ].elementAt(currentPage)),
    );
  }

  Widget _createFloatingActionButton() {
    //TODO: don't forget to add hero widget to post button on newPostPage
    return FloatingActionButton(
        heroTag: "newPost",
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [AppColors.PRIMARY_COLOR, AppColors.SECONDARY_COLOR],
            ),
          ),
          child: Icon(Icons.add),
        ),
        onPressed: goToNewPostPage);
  }

  Widget _createBottomNavBar() {
    return ConvexAppBar.builder(
        itemBuilder: _CustomBuilder(
          [
            TabItem(icon: Icons.search, title: "Search", isIconBlend: true),
            TabItem(icon: Icons.home, title: "Home"),
            TabItem(icon: Icons.person, title: "Profile")
          ],
          AppColors.PRIMARY_COLOR,
        ),
        top: -32,
        chipBuilder: _CustomChipBuilder(),
        height: 56,
        count: 3,
        initialActiveIndex: 1,
        backgroundColor: Theme.of(context).canvasColor,
        curveSize: 70,
        onTap: (int position) => setState(() => currentPage = position));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createAppBar(),
      body: SafeArea(
        child: _createHomePage(),
      ),
      bottomNavigationBar: _createBottomNavBar(),
      floatingActionButton: _createFloatingActionButton(),
    );
  }

  void goToNotificationPage() =>
      Navigator.of(context).pushNamed(Notifications.routeName);

  void goToNewPostPage() => Navigator.of(context).pushNamed(NewPost.routeName);
}

class _CustomBuilder extends DelegateBuilder {
  final List<TabItem> items;
  final Color _tabBackgroundColor;

  _CustomBuilder(this.items, this._tabBackgroundColor);

  @override
  Widget build(BuildContext context, int index, bool active) {
    var navigationItem = items[index];
    var _color = active ? Colors.white : AppColors.PRIMARY_COLOR;

    var _icon = active
        ? navigationItem.activeIcon ?? navigationItem.icon
        : navigationItem.icon;
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          active
              ? Container(
                  padding: EdgeInsets.all(13),
                  margin: EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: this._tabBackgroundColor,
                  ),
                  child: Icon(
                    _icon,
                    color: _color,
                    size: 28,
                  ))
              : Icon(
                  _icon,
                  color: _color,
                  size: 32,
                ),
          active
              ? Text(navigationItem.title,
                  style: TextStyle(color: this._tabBackgroundColor))
              : SizedBox()
        ],
      ),
    );
  }
}

class _CustomChipBuilder extends ChipBuilder {
  @override
  Widget build(BuildContext context, Widget child, int index, bool active) {
    return child;
  }
}

class _AppBarCustomClipPath extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = _getAppBarPath(size);
    return path;
  }

  Path _getAppBarPath(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    var firstControlPoint = Offset(0,
        size.height - 30); // adjust the height to move start of the first curve
    var firstEndPoint = Offset(
        30,
        size.height -
            30); // adjust the width to add the end control point and height to move end of the first curve
    //draw first curve
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    // go to the next point to draw the second curve
    path.lineTo(size.width - 30, size.height - 30);

    var secControlPoint = Offset(size.width,
        size.height - 30); // adjust the height to move end of the second curve
    var secEndPoint = Offset(size.width,
        size.height); // adjust the width to add the right first control point and height to move start of the second curve
    //draw second curve
    path.quadraticBezierTo(
        secControlPoint.dx, secControlPoint.dy, secEndPoint.dx, secEndPoint.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}
