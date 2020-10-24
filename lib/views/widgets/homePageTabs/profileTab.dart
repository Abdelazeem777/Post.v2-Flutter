import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:post/models/post.dart';
import 'package:post/models/user.dart';
import 'package:post/services/currentUser.dart';
import 'package:post/style/appColors.dart';
import 'package:post/utils/sizeConfig.dart';
import 'package:post/views/editPofilePage/editProfilePageViewModel.dart';
import 'package:post/views/home/homeViewModel.dart';
import 'package:post/views/login/loginView.dart';
import 'package:post/views/widgets/stateful/postFrame.dart';
import 'package:post/views/widgets/stateful/postItem.dart';
import 'package:post/views/widgets/stateful/userProfilePicture.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  final ScrollController _scrollController;
  ProfileTab(this._scrollController);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  //for testing
  List<Post> _postsList;
  User _currentUser;

  ProfileTabViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    //for testing
    _postsList = [
      Post.fromJson({
        "postID": 2,
        "userID": 5,
        "postContent": "hello there this my first post",
        "postType": "text",
        "timestamp": 15232323,
        "reactsList": [
          {"userID": 6, "reactType": "ReactType.love"}
        ],
        "numberOfShares": 13,
        "commentsList": [
          {
            "commentID": 6,
            "userID": 3,
            "commentContent": "test",
            "commentType": "text",
            "timestamp": 154578456,
            "reactsList": [
              {"userID": 6, "reactType": "ReactType.love"}
            ],
            "repliesList": [
              {
                "replyID": 5,
                "userID": 5,
                "replyContent": "test",
                "replyType": "text",
                "timestamp": 15325454,
                "reactsList": [
                  {"userID": 6, "reactType": "ReactType.love"}
                ]
              }
            ]
          }
        ]
      }),
      Post.fromJson({
        "postID": 2,
        "userID": 5,
        "postContent": "hello there this my first post",
        "postType": "text",
        "timestamp": 15232323,
        "reactsList": [
          {"userID": 6, "reactType": "ReactType.love"}
        ],
        "numberOfShares": 13,
        "commentsList": [
          {
            "commentID": 6,
            "userID": 3,
            "commentContent": "test",
            "commentType": "text",
            "timestamp": 154578456,
            "reactsList": [
              {"userID": 6, "reactType": "ReactType.love"}
            ],
            "repliesList": [
              {
                "replyID": 5,
                "userID": 5,
                "replyContent": "test",
                "replyType": "text",
                "timestamp": 15325454,
                "reactsList": [
                  {"userID": 6, "reactType": "ReactType.love"}
                ]
              }
            ]
          }
        ]
      }),
      Post.fromJson({
        "postID": 2,
        "userID": 5,
        "postContent":
            "https://upload.wikimedia.org/wikipedia/commons/6/6a/Mona_Lisa.jpg",
        "postType": "image",
        "timestamp": 15232323,
        "reactsList": [
          {"userID": 6, "reactType": "ReactType.love"}
        ],
        "numberOfShares": 13,
        "commentsList": [
          {
            "commentID": 6,
            "userID": 3,
            "commentContent": "test",
            "commentType": "text",
            "timestamp": 154578456,
            "reactsList": [
              {"userID": 6, "reactType": "ReactType.love"}
            ],
            "repliesList": [
              {
                "replyID": 5,
                "userID": 5,
                "replyContent": "test",
                "replyType": "text",
                "timestamp": 15325454,
                "reactsList": [
                  {"userID": 6, "reactType": "ReactType.love"}
                ]
              }
            ]
          }
        ]
      }),
      Post.fromJson({
        "postID": 2,
        "userID": 5,
        "postContent": "hello there this my first post",
        "postType": "text",
        "timestamp": 15232323,
        "reactsList": [
          {"userID": 6, "reactType": "ReactType.love"}
        ],
        "numberOfShares": 13,
        "commentsList": [
          {
            "commentID": 6,
            "userID": 3,
            "commentContent": "test",
            "commentType": "text",
            "timestamp": 154578456,
            "reactsList": [
              {"userID": 6, "reactType": "ReactType.love"}
            ],
            "repliesList": [
              {
                "replyID": 5,
                "userID": 5,
                "replyContent": "test",
                "replyType": "text",
                "timestamp": 15325454,
                "reactsList": [
                  {"userID": 6, "reactType": "ReactType.love"}
                ]
              }
            ]
          }
        ]
      }),
      Post.fromJson({
        "postID": 2,
        "userID": 5,
        "postContent":
            "https://upload.wikimedia.org/wikipedia/commons/6/6a/Mona_Lisa.jpg",
        "postType": "image",
        "timestamp": 15232323,
        "reactsList": [
          {"userID": 6, "reactType": "ReactType.love"}
        ],
        "numberOfShares": 13,
        "commentsList": [
          {
            "commentID": 6,
            "userID": 3,
            "commentContent": "test",
            "commentType": "text",
            "timestamp": 154578456,
            "reactsList": [
              {"userID": 6, "reactType": "ReactType.love"}
            ],
            "repliesList": [
              {
                "replyID": 5,
                "userID": 5,
                "replyContent": "test",
                "replyType": "text",
                "timestamp": 15325454,
                "reactsList": [
                  {"userID": 6, "reactType": "ReactType.love"}
                ]
              }
            ]
          }
        ]
      }),
      Post.fromJson({
        "postID": 2,
        "userID": 5,
        "postContent":
            "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
        "postType": "video",
        "timestamp": 15232323,
        "reactsList": [
          {"userID": 6, "reactType": "ReactType.love"}
        ],
        "numberOfShares": 13,
        "commentsList": [
          {
            "commentID": 6,
            "userID": 3,
            "commentContent": "test",
            "commentType": "text",
            "timestamp": 154578456,
            "reactsList": [
              {"userID": 6, "reactType": "ReactType.love"}
            ],
            "repliesList": [
              {
                "replyID": 5,
                "userID": 5,
                "replyContent": "test",
                "replyType": "text",
                "timestamp": 15325454,
                "reactsList": [
                  {"userID": 6, "reactType": "ReactType.love"}
                ]
              }
            ]
          }
        ]
      }),
      Post.fromJson({
        "postID": 2,
        "userID": 5,
        "postContent":
            "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
        "postType": "video",
        "timestamp": 15232323,
        "reactsList": [
          {"userID": 6, "reactType": "ReactType.love"}
        ],
        "numberOfShares": 13,
        "commentsList": [
          {
            "commentID": 6,
            "userID": 3,
            "commentContent": "test",
            "commentType": "text",
            "timestamp": 154578456,
            "reactsList": [
              {"userID": 6, "reactType": "ReactType.love"}
            ],
            "repliesList": [
              {
                "replyID": 5,
                "userID": 5,
                "replyContent": "test",
                "replyType": "text",
                "timestamp": 15325454,
                "reactsList": [
                  {"userID": 6, "reactType": "ReactType.love"}
                ]
              }
            ]
          }
        ]
      }),
      Post.fromJson({
        "postID": 2,
        "userID": 5,
        "postContent":
            "https://scontent.faly3-1.fna.fbcdn.net/v/t1.0-9/110315437_3755160424510365_6402932283883372240_n.jpg?_nc_cat=101&_nc_sid=09cbfe&_nc_ohc=IcR2YHTf8hAAX-WZLXa&_nc_oc=AQn5Ppu-T8UZf0D9Ne-2uxQq3DPhRTa5AY739QhLYyKwYvJaANUY2VMPmUwybfLPbPY&_nc_ht=scontent.faly3-1.fna&oh=8d5a1ac72b74646168943f9c1ad7e17d&oe=5F6C14E4",
        "postType": "image",
        "timestamp": 15232323,
        "reactsList": [
          {"userID": 6, "reactType": "ReactType.love"}
        ],
        "numberOfShares": 13,
        "commentsList": [
          {
            "commentID": 6,
            "userID": 3,
            "commentContent": "test",
            "commentType": "text",
            "timestamp": 154578456,
            "reactsList": [
              {"userID": 6, "reactType": "ReactType.love"}
            ],
            "repliesList": [
              {
                "replyID": 5,
                "userID": 5,
                "replyContent": "test",
                "replyType": "text",
                "timestamp": 15325454,
                "reactsList": [
                  {"userID": 6, "reactType": "ReactType.love"}
                ]
              }
            ]
          }
        ]
      }),
    ];

    _currentUser = CurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ProfileTabViewModel(),
        child: Container(
          color: Colors.grey[200],
          child: ListView(
            controller: this.widget._scrollController,
            padding: EdgeInsets.all(0),
            children: _createListViewChildren(),
          ),
        ));
  }

  List<Widget> _createListViewChildren() {
    List<Widget> listViewChildren = [];
    listViewChildren.add(_createUserProfileTopBar());
    _postsList.forEach(
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
      margin: EdgeInsets.only(top: 75),
      padding: EdgeInsets.only(top: 16, left: 16, bottom: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: AppColors.SECONDARY_COLOR))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _createCurrentUserProfilePicture(),
              _createFollowersAndButtons() //at the right side
            ],
          ),
          _createUserNameAndBio(),
        ],
      ),
    );
  }

  Widget _createCurrentUserProfilePicture() {
    return Container(
      margin: EdgeInsets.only(right: 16),
      width: SizeConfig.safeBlockHorizontal * 25,
      height: SizeConfig.safeBlockHorizontal * 25,
      child: UserProfilePicture(
        imageURL: _currentUser.userProfilePicURL,
      ),
    );
  }

  Widget _createFollowersAndButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _createFollowersText(),
        _createEditAndLogoutButtons(),
      ],
    );
  }

  Widget _createUserNameAndBio() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _currentUser.userName,
          style: TextStyle(fontSize: 16),
        ),
        Text(
          _currentUser.bio,
          style: TextStyle(color: Colors.grey, fontSize: 13),
        )
      ],
    );
  }

  ///    9        7         17
  ///  Posts  Followers  Following
  /// it create the design for the number of post, followers and following
  Widget _createFollowersText() {
    return Row(
      children: [
        _createText(
            number: _currentUser.postsList.length,
            text: "Posts",
            onPressed: () {}),
        _createText(
            number: _currentUser.followersList.length,
            text: "Followers",
            onPressed: () {}),
        _createText(
            number: _currentUser.followingRankedList.length,
            text: "Following",
            onPressed: () {})
      ],
    );
  }

  Widget _createText({int number, String text, Function() onPressed}) {
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
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
        onTap: onPressed,
      ),
    );
  }

  Widget _createEditAndLogoutButtons() {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 16, top: 16, bottom: 16),
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
          padding: EdgeInsets.fromLTRB(10, 8, 12, 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: AppColors.PRIMARY_COLOR)),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 6),
                child: Icon(
                  Icons.edit,
                  size: 21,
                  color: AppColors.PRIMARY_COLOR,
                ),
              ),
              Text(
                'Edit Profile',
                style: TextStyle(color: AppColors.PRIMARY_COLOR),
              ),
            ],
          )),
    );
  }

  Widget _createLogoutButton() {
    return Selector<ProfileTabViewModel, bool>(selector: (context, viewModel) {
      this._viewModel = viewModel;
    }, builder: (context, logoutSuccess, child) {
      return InkWell(
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
            size: 20,
          ),
        ),
      );
    });
  }

  void _goToLoginPage() =>
      Navigator.of(context).popAndPushNamed(Login.routeName);

  void _goToEditProfilePage() =>
      Navigator.of(context).pushNamed(EditProfilePage.routeName);
}
