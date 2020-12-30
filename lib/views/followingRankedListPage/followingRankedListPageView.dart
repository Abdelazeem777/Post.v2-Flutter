import 'package:flutter/material.dart';

import 'package:post/services/currentUser.dart';
import 'package:post/style/appColors.dart';
import 'package:post/views/followingRankedListPage/followingRankedListPageViewModel.dart';
import 'package:post/views/widgets/stateless/userItemCard.dart';
import 'package:provider/provider.dart';

class FollowingRankedListPage extends StatefulWidget {
  static const String routeName = '/FollowingRankedListPage';
  @override
  _FollowingRankedListPageState createState() =>
      _FollowingRankedListPageState();
}

class _FollowingRankedListPageState extends State<FollowingRankedListPage> {
  final _viewModel = FollowingRankedListViewModel();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider.value(value: CurrentUser()),
        ListenableProvider<FollowingRankedListViewModel>(
            create: (context) => _viewModel),
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
        "Following",
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Theme.of(context).canvasColor,
      iconTheme: IconThemeData(color: AppColors.PRIMARY_COLOR),
    );
  }

  Widget _createReorderableListView() {
    return Consumer<FollowingRankedListViewModel>(
      builder: (context, viewModel, _) => ReorderableListView(
        padding: EdgeInsets.all(16),
        children: _getListItems(),
        onReorder: _viewModel.reorder,
        header: Text('You can move users to change the Rank'),
      ),
    );
  }

  List<Widget> _getListItems() {
    List<Widget> children = List<Widget>();
    for (int i = 0; i < _viewModel.usersList.length; i++) {
      children.add(UserItemCard(
        key: ValueKey(_viewModel.usersList[i]),
        user: _viewModel.usersList[i],
        viewModel: _viewModel,
        withRank: true,
      ));
    }
    return children;
  }
}
