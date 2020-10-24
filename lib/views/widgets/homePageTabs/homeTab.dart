import 'package:flutter/material.dart';
import 'package:post/services/currentUser.dart';
import 'package:post/models/post.dart';
import 'package:post/models/user.dart';
import 'package:post/views/widgets/stateful/postFrame.dart';

class HomeTab extends StatefulWidget {
  final ScrollController _scrollController;
  HomeTab(this._scrollController);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<Post> _postsList;
  @override
  void initState() {
    super.initState();
    _postsList = [
      Post.fromJson({
        "postID": 2,
        "userID": 5,
        "postContent": "hello there this my first post",
        "postType": "Text",
        "timestamp":
            DateTime.now().subtract(Duration(days: 45)).millisecondsSinceEpoch,
        "reactsList": [
          {"userID": 6, "reactType": "Love"},
          {"userID": 6, "reactType": "Like"},
          {"userID": 6, "reactType": "Angry"},
          {"userID": 6, "reactType": "Haha"},
          {"userID": 6, "reactType": "Haha"},
          {"userID": 6, "reactType": "Sad"},
          {"userID": 6, "reactType": "Love"}
        ],
        "numberOfShares": 13,
        "commentsList": [
          {
            "commentID": 6,
            "userID": 3,
            "commentContent": "this comment is just for testing\nbla bla bla",
            "commentType": "Text",
            "timestamp": DateTime.now()
                .subtract(Duration(hours: 4))
                .millisecondsSinceEpoch,
            "reactsList": [
              {"userID": 6, "reactType": "Love"}
            ],
            "repliesList": [
              {
                "replyID": 5,
                "userID": 5,
                "replyContent": "this reply is just for testing\nbla bla bla",
                "replyType": "Text",
                "timestamp": DateTime.now()
                    .subtract(Duration(minutes: 15))
                    .millisecondsSinceEpoch,
                "reactsList": [
                  {"userID": 6, "reactType": "Love"}
                ]
              },
              {
                "replyID": 5,
                "userID": 5,
                "replyContent": "this reply is just for testing\nbla bla bla",
                "replyType": "Text",
                "timestamp": DateTime.now()
                    .subtract(Duration(minutes: 15))
                    .millisecondsSinceEpoch,
                "reactsList": [
                  {"userID": 6, "reactType": "Love"}
                ]
              },
              {
                "replyID": 5,
                "userID": 5,
                "replyContent": "this reply is just for testing\nbla bla bla",
                "replyType": "Text",
                "timestamp": DateTime.now()
                    .subtract(Duration(minutes: 15))
                    .millisecondsSinceEpoch,
                "reactsList": [
                  {"userID": 6, "reactType": "Love"}
                ]
              },
            ]
          },
          {
            "commentID": 6,
            "userID": 3,
            "commentContent": "this comment is just for testing\nbla bla bla",
            "commentType": "Text",
            "timestamp": DateTime.now()
                .subtract(Duration(hours: 4))
                .millisecondsSinceEpoch,
            "reactsList": [
              {"userID": 6, "reactType": "Love"}
            ],
            "repliesList": [
              {
                "replyID": 5,
                "userID": 5,
                "replyContent": "this reply is just for testing\nbla bla bla",
                "replyType": "Text",
                "timestamp": DateTime.now()
                    .subtract(Duration(minutes: 15))
                    .millisecondsSinceEpoch,
                "reactsList": [
                  {"userID": 6, "reactType": "Love"}
                ]
              },
              {
                "replyID": 5,
                "userID": 5,
                "replyContent": "this reply is just for testing\nbla bla bla",
                "replyType": "Text",
                "timestamp": DateTime.now()
                    .subtract(Duration(minutes: 15))
                    .millisecondsSinceEpoch,
                "reactsList": [
                  {"userID": 6, "reactType": "Love"}
                ]
              },
              {
                "replyID": 5,
                "userID": 5,
                "replyContent": "this reply is just for testing\nbla bla bla",
                "replyType": "Text",
                "timestamp": DateTime.now()
                    .subtract(Duration(minutes: 15))
                    .millisecondsSinceEpoch,
                "reactsList": [
                  {"userID": 6, "reactType": "Love"}
                ]
              },
            ]
          }
        ]
      }),
      Post.fromJson({
        "postID": 2,
        "userID": 5,
        "postContent": "hello there this my first post",
        "postType": "Text",
        "timestamp":
            DateTime.now().subtract(Duration(days: 45)).millisecondsSinceEpoch,
        "reactsList": [
          {"userID": 6, "reactType": "Love"}
        ],
        "numberOfShares": 13,
        "commentsList": [
          {
            "commentID": 6,
            "userID": 3,
            "commentContent": "test",
            "commentType": "Text",
            "timestamp": DateTime.now()
                .subtract(Duration(hours: 4))
                .millisecondsSinceEpoch,
            "reactsList": [
              {"userID": 6, "reactType": "Love"}
            ],
            "repliesList": [
              {
                "replyID": 5,
                "userID": 5,
                "replyContent": "test",
                "replyType": "Text",
                "timestamp": DateTime.now()
                    .subtract(Duration(minutes: 15))
                    .millisecondsSinceEpoch,
                "reactsList": [
                  {"userID": 6, "reactType": "Love"}
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
        "postType": "Image",
        "timestamp":
            DateTime.now().subtract(Duration(days: 45)).millisecondsSinceEpoch,
        "reactsList": [
          {"userID": 6, "reactType": "Love"}
        ],
        "numberOfShares": 13,
        "commentsList": [
          {
            "commentID": 6,
            "userID": 3,
            "commentContent": "test",
            "commentType": "Text",
            "timestamp": DateTime.now()
                .subtract(Duration(hours: 4))
                .millisecondsSinceEpoch,
            "reactsList": [
              {"userID": 6, "reactType": "Love"}
            ],
            "repliesList": [
              {
                "replyID": 5,
                "userID": 5,
                "replyContent": "test",
                "replyType": "Text",
                "timestamp": DateTime.now()
                    .subtract(Duration(minutes: 15))
                    .millisecondsSinceEpoch,
                "reactsList": [
                  {"userID": 6, "reactType": "Love"}
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
        "postType": "Text",
        "timestamp":
            DateTime.now().subtract(Duration(days: 45)).millisecondsSinceEpoch,
        "reactsList": [
          {"userID": 6, "reactType": "Love"}
        ],
        "numberOfShares": 13,
        "commentsList": [
          {
            "commentID": 6,
            "userID": 3,
            "commentContent": "test",
            "commentType": "Text",
            "timestamp": DateTime.now()
                .subtract(Duration(hours: 4))
                .millisecondsSinceEpoch,
            "reactsList": [
              {"userID": 6, "reactType": "Love"}
            ],
            "repliesList": [
              {
                "replyID": 5,
                "userID": 5,
                "replyContent": "test",
                "replyType": "Text",
                "timestamp": DateTime.now()
                    .subtract(Duration(minutes: 15))
                    .millisecondsSinceEpoch,
                "reactsList": [
                  {"userID": 6, "reactType": "Love"}
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
        "postType": "Image",
        "timestamp":
            DateTime.now().subtract(Duration(days: 45)).millisecondsSinceEpoch,
        "reactsList": [
          {"userID": 6, "reactType": "Love"}
        ],
        "numberOfShares": 13,
        "commentsList": [
          {
            "commentID": 6,
            "userID": 3,
            "commentContent": "test",
            "commentType": "Text",
            "timestamp": DateTime.now()
                .subtract(Duration(hours: 4))
                .millisecondsSinceEpoch,
            "reactsList": [
              {"userID": 6, "reactType": "Love"}
            ],
            "repliesList": [
              {
                "replyID": 5,
                "userID": 5,
                "replyContent": "test",
                "replyType": "Text",
                "timestamp": DateTime.now()
                    .subtract(Duration(minutes: 15))
                    .millisecondsSinceEpoch,
                "reactsList": [
                  {"userID": 6, "reactType": "Love"}
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
            "http://commondatastorage.googleapis.com/gtv-Videos-bucket/sample/BigBuckBunny.mp4",
        "postType": "Video",
        "timestamp":
            DateTime.now().subtract(Duration(days: 45)).millisecondsSinceEpoch,
        "reactsList": [
          {"userID": 6, "reactType": "Love"}
        ],
        "numberOfShares": 13,
        "commentsList": [
          {
            "commentID": 6,
            "userID": 3,
            "commentContent": "test",
            "commentType": "Text",
            "timestamp": DateTime.now()
                .subtract(Duration(hours: 4))
                .millisecondsSinceEpoch,
            "reactsList": [
              {"userID": 6, "reactType": "Love"}
            ],
            "repliesList": [
              {
                "replyID": 5,
                "userID": 5,
                "replyContent": "test",
                "replyType": "Text",
                "timestamp": DateTime.now()
                    .subtract(Duration(minutes: 15))
                    .millisecondsSinceEpoch,
                "reactsList": [
                  {"userID": 6, "reactType": "Love"}
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
            "http://commondatastorage.googleapis.com/gtv-Videos-bucket/sample/BigBuckBunny.mp4",
        "postType": "Video",
        "timestamp":
            DateTime.now().subtract(Duration(days: 45)).millisecondsSinceEpoch,
        "reactsList": [
          {"userID": 6, "reactType": "Love"}
        ],
        "numberOfShares": 13,
        "commentsList": [
          {
            "commentID": 6,
            "userID": 3,
            "commentContent": "test",
            "commentType": "Text",
            "timestamp": DateTime.now()
                .subtract(Duration(hours: 4))
                .millisecondsSinceEpoch,
            "reactsList": [
              {"userID": 6, "reactType": "Love"}
            ],
            "repliesList": [
              {
                "replyID": 5,
                "userID": 5,
                "replyContent": "test",
                "replyType": "Text",
                "timestamp": DateTime.now()
                    .subtract(Duration(minutes: 15))
                    .millisecondsSinceEpoch,
                "reactsList": [
                  {"userID": 6, "reactType": "Love"}
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
            "https://scontent.faly3-1.fna.fbcdn.net/v/t1.0-9/110315437_3755160424510365_6402932283883372240_n.jpg?_nc_cat=101&_nc_sid=09cbfe&_nc_eui2=AeFMHjrJL0Cx3_MEqSLa0IsM_Ybpoqq_bMz9humiqr9szE5q5si_w_5hAcW_t9VHUZ_Oe3RduQZd8z55MkYjfkTY&_nc_ohc=s5-Ed3UWf0cAX9Higb4&_nc_oc=AQnzdoJD0_ZUAdAhOorbkxZ3HQgSXev3aO5P_jassAaYFXI1QIUVo1klgnhS9bN3QHA&_nc_ht=scontent.faly3-1.fna&oh=fffea7e08751b42fdc94b8b16977f071&oe=5F9F7F64",
        "postType": "Image",
        "timestamp":
            DateTime.now().subtract(Duration(days: 45)).millisecondsSinceEpoch,
        "reactsList": [
          {"userID": 6, "reactType": "Love"}
        ],
        "numberOfShares": 13,
        "commentsList": [
          {
            "commentID": 6,
            "userID": 3,
            "commentContent": "test",
            "commentType": "Text",
            "timestamp": DateTime.now()
                .subtract(Duration(hours: 4))
                .millisecondsSinceEpoch,
            "reactsList": [
              {"userID": 6, "reactType": "Love"}
            ],
            "repliesList": [
              {
                "replyID": 5,
                "userID": 5,
                "replyContent": "test",
                "replyType": "Text",
                "timestamp": DateTime.now()
                    .subtract(Duration(minutes: 15))
                    .millisecondsSinceEpoch,
                "reactsList": [
                  {"userID": 6, "reactType": "Love"}
                ]
              }
            ]
          }
        ]
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: this.widget._scrollController,
        itemBuilder: (context, index) => PostFrame(
              multiplePosts: true,
              postsList: _postsList,
              postOwnerUser: User(
                  userName: "Abdelazeem Kuratem",
                  bio: "Mobile developer",
                  followersList: [1, 5, 6, 7, 2, 8, 9],
                  followingRankedList: [
                    1,
                    5,
                    3,
                    8,
                    4,
                    44,
                    33,
                    98,
                    841,
                    12152151,
                    17,
                    262,
                    65,
                    62,
                    32,
                    456,
                    26
                  ],
                  postsList: [1, 3, 5, 12, 4, 8, 9, 6, 7],
                  userProfilePicURL:
                      "https://scontent.faly3-1.fna.fbcdn.net/v/t1.0-9/110315437_3755160424510365_6402932283883372240_n.jpg?_nc_cat=101&_nc_sid=09cbfe&_nc_eui2=AeFMHjrJL0Cx3_MEqSLa0IsM_Ybpoqq_bMz9humiqr9szE5q5si_w_5hAcW_t9VHUZ_Oe3RduQZd8z55MkYjfkTY&_nc_ohc=s5-Ed3UWf0cAX9Higb4&_nc_oc=AQnzdoJD0_ZUAdAhOorbkxZ3HQgSXev3aO5P_jassAaYFXI1QIUVo1klgnhS9bN3QHA&_nc_ht=scontent.faly3-1.fna&oh=fffea7e08751b42fdc94b8b16977f071&oe=5F9F7F64"),
            ));
  }
}
