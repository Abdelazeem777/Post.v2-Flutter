import 'package:flutter/material.dart';
import 'package:post/models/user.dart';
import 'package:post/style/appColors.dart';
import 'package:post/views/home/homeViewModel.dart';
import 'package:post/views/widgets/stateless/userItem.dart';
import 'package:provider/provider.dart';

class SearchTab extends StatefulWidget {
  final ScrollController _scrollController;

  final FocusNode _searchFocusNode;
  SearchTab(this._scrollController, this._searchFocusNode);

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  SearchTabViewModel _viewModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = Provider.of<SearchTabViewModel>(context);
    return Column(
      children: [
        _createSearchTextField(),
        Flexible(
          child: Selector<SearchTabViewModel, List<User>>(
            selector: (_, viewModel) => viewModel.usersList,
            builder: (_, usersList, __) => usersList.length > 0
                ? ListView.builder(
                    padding: EdgeInsets.all(0),
                    // controller: this.widget._scrollController,
                    itemCount: usersList.length,
                    itemBuilder: (context, position) {
                      return UserItem(user: usersList[position]);
                    },
                  )
                : const _FindNewFriendsHint(),
          ),
        ),
      ],
    );
  }

  Widget _createSearchTextField() {
    return Container(
      margin: EdgeInsets.only(top: 92, bottom: 16, right: 16, left: 16),
      child: TextField(
        cursorColor: AppColors.PRIMARY_COLOR,
        focusNode: widget._searchFocusNode,
        controller: _viewModel.searchTextController,
        maxLines: 1,
        decoration: InputDecoration(
          hintText: 'Search',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          contentPadding:
              EdgeInsets.only(top: 16, bottom: 16, left: 26, right: 16),
          fillColor: Color.fromARGB(70, 175, 231, 130),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.grey[700],
            ),
            onPressed: _removeTextFromSearchTextField,
          ),
        ),
        onChanged: _viewModel.onSearchTextChanged,
      ),
    );
  }

  void _removeTextFromSearchTextField() {
    _viewModel.searchTextController.clear();
    this.widget._searchFocusNode.requestFocus();
  }
}

class _FindNewFriendsHint extends StatelessWidget {
  const _FindNewFriendsHint({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Find new friends',
        textAlign: TextAlign.center,
      ),
    );
  }
}
