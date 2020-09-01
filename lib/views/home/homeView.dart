import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  int _currentPage = 1;
  bool _isVisible = true;

  ScrollController _scrollController;
  TextEditingController _searchTextController;
  FocusNode _searchFocusNode;

  @override
  initState() {
    super.initState();
    _searchTextController = TextEditingController();
    _searchFocusNode = FocusNode();
    _scrollController = new ScrollController();
    _addListenerToScrollController();
  }

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
                            onPressed: _goToNotificationPage),
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
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: [
          SearchTab(_scrollController, _searchTextController, _searchFocusNode),
          HomeTab(_scrollController),
          ProfileTab(_scrollController),
        ].elementAt(_currentPage));
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
        onPressed: _goToNewPostPage);
  }

  Widget _createBottomNavBar() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _isVisible ? 56 : 0,
      child: ListView(
        children: [
          ConvexAppBar.builder(
            itemBuilder: _CustomBuilder(
              [
                TabItem(icon: Icons.search, title: "Search"),
                TabItem(icon: Icons.home, title: "Home"),
                TabItem(icon: Icons.person, title: "Profile")
              ],
              AppColors.PRIMARY_COLOR,
            ),
            top: -32,
            height: 56,
            count: 3,
            initialActiveIndex: 1,
            backgroundColor: Theme.of(context).canvasColor,
            curveSize: 70,
            onTap: (int position) {
              if (position == 0) _searchFocusNode.requestFocus();
              setState(() => _currentPage = position);
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createAppBar(),
      body: SafeArea(
        top: false,
        child: _createHomePage(),
      ),
      bottomNavigationBar: _createBottomNavBar(),
      floatingActionButton:
          _currentPage == 1 ? _createFloatingActionButton() : null,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomPadding: false,
    );
  }

  void _goToNotificationPage() =>
      Navigator.of(context).pushNamed(Notifications.routeName);

  void _goToNewPostPage() => Navigator.of(context).pushNamed(NewPost.routeName);

  void _addListenerToScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
              ScrollDirection.reverse &&
          _isVisible)
        _changeNavBarVisibilityState();
      else if (_scrollController.position.userScrollDirection ==
              ScrollDirection.forward &&
          !_isVisible) _changeNavBarVisibilityState();
    });
  }

  void _changeNavBarVisibilityState() =>
      setState(() => _isVisible = !_isVisible);
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
      alignment: Alignment.center,
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Column(
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
          )
        ],
      ),
    );
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
