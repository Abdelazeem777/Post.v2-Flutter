import 'package:flutter/material.dart';
import 'package:post/models/post.dart';
import 'package:post/models/user.dart';
import 'package:post/services/currentUser.dart';
import 'package:post/views/home/homeViewModel.dart';
import 'package:post/views/widgets/stateful/postFrame.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class HomeTab extends StatefulWidget {
  final ScrollController _scrollController;
  HomeTab(this._scrollController);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  HomeTabViewModel _viewModel;
  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<HomeTabViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Selector<HomeTabViewModel, int>(
      selector: (_, viewModel) {
        var usersCount = viewModel.followingUsers.length;
        return usersCount;
      },
      builder: (_, usersCount, ___) => ListView.builder(
          controller: this.widget._scrollController,
          itemCount: usersCount,
          itemBuilder: (context, index) {
            return Selector<HomeTabViewModel, int>(
              selector: (_, viewModel) => viewModel.postsList.length,
              builder: (_, __, ___) {
                final postOwnerUser = _viewModel?.followingUsers[index];
                final postsList = _viewModel.postsList
                    .where((post) => post.userID == postOwnerUser.userID)
                    .toList();
                return postOwnerUser != null
                    ? PostFrame(
                        multiplePosts: true,
                        postsList: postsList,
                        postOwnerUser: postOwnerUser,
                        rank: index + 1,
                      )
                    : Container();
              },
            );
          }),
    );
  }
}
