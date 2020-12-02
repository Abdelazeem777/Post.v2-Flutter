import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:post/models/post.dart';
import 'package:post/models/user.dart';
import 'package:post/services/currentUser.dart';
import 'package:post/style/appColors.dart';
import 'package:post/utils/sizeConfig.dart';
import 'package:post/views/editPofilePage/editProfilePageView.dart';
import 'package:post/views/followersListPage/followersListPageView.dart';
import 'package:post/views/followingRankedListPage/followingRankedListPageView.dart';
import 'package:post/views/home/homeViewModel.dart';
import 'package:post/views/login/loginView.dart';
import 'package:post/views/widgets/stateful/postFrame.dart';
import 'package:post/views/widgets/stateful/postItem.dart';
import 'package:post/views/widgets/stateful/userProfilePicture.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class ProfileTab extends StatefulWidget {
  final ScrollController _scrollController;
  ProfileTab(this._scrollController);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  User _currentUser;

  ProfileTabViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _currentUser = CurrentUser();
    _viewModel = Provider.of<ProfileTabViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Selector<ProfileTabViewModel, List<Post>>(
          selector: (_, viewModel) => viewModel.postsList,
          builder: (context, value, child) => ListView(
            controller: this.widget._scrollController,
            padding: EdgeInsets.all(0),
            children: _createListViewChildren(),
          ),
        ));
  }

  List<Widget> _createListViewChildren() {
    List<Widget> listViewChildren = [];
    listViewChildren.add(_createUserProfileTopBar());
    _viewModel.postsList.forEach(
      (post) => listViewChildren.add(
        PostFrame(
          postsList: [post],
          postOwnerUser: _currentUser,
        ),
      ),
    );
    return listViewChildren;
  }

  Widget _createUserProfileTopBar() {
    return Container(
      width: SizeConfig.screenWidth,
      margin: EdgeInsets.only(top: 75, bottom: 16),
      padding: EdgeInsets.only(left: 16, bottom: 16, top: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColors.SECONDARY_COLOR)),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: Colors.black12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _createCurrentUserProfilePicture(),
              _createFollowersText()
            ],
          ),
          Container(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _createUserNameAndBio(),
              _createEditAndLogoutButtons(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _createCurrentUserProfilePicture() {
    return Container(
        margin: EdgeInsets.only(right: 16),
        width: SizeConfig.safeBlockHorizontal * 25,
        height: SizeConfig.safeBlockHorizontal * 25,
        child: Selector<CurrentUser, String>(
          selector: (_, currentUser) => CurrentUser().userProfilePicURL,
          builder: (_, userProfilePicURL, __) => Hero(
            tag: "CurrentUserProfilePic",
            child: Material(
              type: MaterialType.transparency,
              child: UserProfilePicture(
                imageURL: userProfilePicURL,
              ),
            ),
          ),
        ));
  }

  Widget _createUserNameAndBio() {
    return Selector<CurrentUser, Tuple2<String, String>>(
      selector: (_, currentUser) =>
          Tuple2(currentUser.userName, currentUser.bio),
      builder: (_, data, __) => SizedBox(
        width: SizeConfig.screenWidth / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.item1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16),
            ),
            Text(
              data.item2,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            )
          ],
        ),
      ),
    );
  }

  ///    9        7         17
  ///  Posts  Followers  Following
  /// it create the design for the number of post, followers and following
  Widget _createFollowersText() {
    return Consumer<CurrentUser>(
      builder: (context, _, __) => Row(
        children: [
          UserProfileText(
              number: _currentUser.postsList.length,
              text: "Posts",
              onPressed: () {}),
          UserProfileText(
              number: _currentUser.followersList.length,
              text: "Followers",
              onPressed: _goToFollowersListPage),
          UserProfileText(
              number: _currentUser.followingRankedList.length,
              text: "Following",
              onPressed: _goToFollowingListPage)
        ],
      ),
    );
  }

  Widget _createEditAndLogoutButtons() {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 8),
          child: _createEditProfileButton(),
        ),
        _createLogoutButton(),
      ],
    );
  }

  Widget _createEditProfileButton() {
    return InkWell(
      onTap: _goToEditProfilePage,
      child: Container(
          padding: EdgeInsets.fromLTRB(6, 7, 8, 7),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: AppColors.PRIMARY_COLOR)),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 4),
                child: Icon(
                  Icons.edit,
                  size: 21,
                  color: AppColors.PRIMARY_COLOR,
                ),
              ),
              Text(
                'Edit Profile',
                style: TextStyle(fontSize: 13, color: AppColors.PRIMARY_COLOR),
              ),
            ],
          )),
    );
  }

  Widget _createLogoutButton() {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: InkWell(
        onTap: () => _viewModel.logout(onLogoutSuccess: _goToLoginPage),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.red)),
          child: Icon(
            FontAwesomeIcons.signOutAlt,
            color: Colors.red,
            size: 18,
          ),
        ),
      ),
    );
  }

  void _goToLoginPage() =>
      Navigator.of(context).popAndPushNamed(Login.routeName);

  void _goToEditProfilePage() =>
      Navigator.of(context).pushNamed(EditProfilePage.routeName);

  void _goToFollowingListPage() =>
      Navigator.of(context).pushNamed(FollowingRankedListPage.routeName);
  void _goToFollowersListPage() =>
      Navigator.of(context).pushNamed(FollowersListPage.routeName);
}

class UserProfileText extends StatelessWidget {
  const UserProfileText({
    Key key,
    @required this.number,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  final int number;
  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8),
      child: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              number.toString(),
              style: TextStyle(fontSize: 16),
            ),
            Text(
              text,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
        onTap: onPressed,
      ),
    );
  }
}
