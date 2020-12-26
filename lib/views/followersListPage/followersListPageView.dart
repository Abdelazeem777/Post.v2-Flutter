import 'package:flutter/material.dart';
import 'package:post/services/currentUser.dart';
import 'package:post/style/appColors.dart';
import 'package:post/views/widgets/stateless/userItemCard.dart';
import 'package:provider/provider.dart';

import 'followerListPageViewModel.dart';

class FollowersListPage extends StatefulWidget {
  static const String routeName = '/FollowersListPage';
  @override
  _FollowersListPageState createState() => _FollowersListPageState();
}

class _FollowersListPageState extends State<FollowersListPage> {
  final _viewModel = FollowersListViewModel();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider.value(value: CurrentUser()),
        ListenableProvider<FollowersListViewModel>(
          create: (context) => _viewModel,
        )
      ],
      builder: (context, child) => Scaffold(
        appBar: _createAppBar(),
        body: _createReorderableListView(),
      ),
    );
  }

  Widget _createAppBar() {
    return AppBar(
      shadowColor: AppColors.SECONDARY_COLOR,
      title: Text(
        "Followers",
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Theme.of(context).canvasColor,
      iconTheme: IconThemeData(color: AppColors.PRIMARY_COLOR),
    );
  }

  Widget _createReorderableListView() {
    return Consumer<FollowersListViewModel>(
      builder: (context, _, __) => ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: _viewModel.usersList.length,
        itemBuilder: (BuildContext context, int i) {
          return UserItemCard(
            key: ValueKey(_viewModel.usersList[i]),
            user: _viewModel.usersList[i],
            viewModel: _viewModel,
          );
        },
      ),
    );
  }

  List<Widget> _getListItems() {
    List<Widget> children = List<Widget>();
    for (int i = 0; i < _viewModel.usersList.length; i++) {}
    return children;
  }
}
