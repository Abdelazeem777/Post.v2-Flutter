import 'package:flutter/material.dart';
import 'package:post/models/user.dart';
import 'package:post/style/appColors.dart';
import 'package:post/views/widgets/stateful/userItem.dart';

class SearchTab extends StatefulWidget {
  final ScrollController _scrollController;
  final TextEditingController _searchController;
  final FocusNode _searchFocusNode;
  SearchTab(
      this._scrollController, this._searchController, this._searchFocusNode);

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  List<User> _usersList;

  @override
  void initState() {
    super.initState();
    _usersList = [
      User(
        userName: 'Abdelazeem Kuratem',
        bio: 'Mobile developer',
        active: true,
        following: false,
        userProfilePicURL:
            "https://scontent.faly3-1.fna.fbcdn.net/v/t1.0-9/110315437_3755160424510365_6402932283883372240_n.jpg?_nc_cat=101&_nc_sid=09cbfe&_nc_ohc=IcR2YHTf8hAAX-WZLXa&_nc_oc=AQn5Ppu-T8UZf0D9Ne-2uxQq3DPhRTa5AY739QhLYyKwYvJaANUY2VMPmUwybfLPbPY&_nc_ht=scontent.faly3-1.fna&oh=8d5a1ac72b74646168943f9c1ad7e17d&oe=5F6C14E4",
      ),
      User(
        userName: 'Abdelazeem Kuratem',
        bio: 'Mobile developer',
        active: false,
        following: true,
        userProfilePicURL:
            "https://scontent.faly3-1.fna.fbcdn.net/v/t1.0-9/110315437_3755160424510365_6402932283883372240_n.jpg?_nc_cat=101&_nc_sid=09cbfe&_nc_ohc=IcR2YHTf8hAAX-WZLXa&_nc_oc=AQn5Ppu-T8UZf0D9Ne-2uxQq3DPhRTa5AY739QhLYyKwYvJaANUY2VMPmUwybfLPbPY&_nc_ht=scontent.faly3-1.fna&oh=8d5a1ac72b74646168943f9c1ad7e17d&oe=5F6C14E4",
      ),
      User(
        userName: 'Abdelazeem Kuratem',
        bio: 'Mobile developer',
        active: false,
        following: false,
        userProfilePicURL:
            "https://scontent.faly3-1.fna.fbcdn.net/v/t1.0-9/110315437_3755160424510365_6402932283883372240_n.jpg?_nc_cat=101&_nc_sid=09cbfe&_nc_ohc=IcR2YHTf8hAAX-WZLXa&_nc_oc=AQn5Ppu-T8UZf0D9Ne-2uxQq3DPhRTa5AY739QhLYyKwYvJaANUY2VMPmUwybfLPbPY&_nc_ht=scontent.faly3-1.fna&oh=8d5a1ac72b74646168943f9c1ad7e17d&oe=5F6C14E4",
      ),
      User(
        userName: 'Abdelazeem Kuratem',
        bio: 'Mobile developer',
        active: false,
        following: false,
        userProfilePicURL: "default",
      ),
      User(
        userName: 'Abdelazeem Kuratem',
        bio: 'Mobile developer',
        active: true,
        following: true,
        userProfilePicURL: "default",
      ),
      User(
        userName: 'Abdelazeem Kuratem',
        bio: 'Mobile developer',
        active: true,
        following: false,
        userProfilePicURL:
            "https://scontent.faly3-1.fna.fbcdn.net/v/t1.0-9/110315437_3755160424510365_6402932283883372240_n.jpg?_nc_cat=101&_nc_sid=09cbfe&_nc_ohc=IcR2YHTf8hAAX-WZLXa&_nc_oc=AQn5Ppu-T8UZf0D9Ne-2uxQq3DPhRTa5AY739QhLYyKwYvJaANUY2VMPmUwybfLPbPY&_nc_ht=scontent.faly3-1.fna&oh=8d5a1ac72b74646168943f9c1ad7e17d&oe=5F6C14E4",
      ),
      User(
        userName: 'Abdelazeem Kuratem',
        bio: 'Mobile developer',
        active: false,
        following: true,
        userProfilePicURL: "default",
      ),
      User(
        userName: 'Abdelazeem Kuratem',
        bio: 'Mobile developer',
        active: true,
        following: false,
        userProfilePicURL:
            "https://scontent.faly3-1.fna.fbcdn.net/v/t1.0-9/110315437_3755160424510365_6402932283883372240_n.jpg?_nc_cat=101&_nc_sid=09cbfe&_nc_ohc=IcR2YHTf8hAAX-WZLXa&_nc_oc=AQn5Ppu-T8UZf0D9Ne-2uxQq3DPhRTa5AY739QhLYyKwYvJaANUY2VMPmUwybfLPbPY&_nc_ht=scontent.faly3-1.fna&oh=8d5a1ac72b74646168943f9c1ad7e17d&oe=5F6C14E4",
      ),
    ];
  }

  Widget _createSearchTextField() {
    return Container(
      margin: EdgeInsets.only(top: 92, bottom: 16, right: 16, left: 16),
      child: TextField(
          cursorColor: AppColors.PRIMARY_COLOR,
          focusNode: this.widget._searchFocusNode,
          controller: this.widget._searchController,
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
              ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _createSearchTextField(),
        Flexible(
          child: ListView.builder(
            padding: EdgeInsets.all(0),
            controller: this.widget._scrollController,
            itemCount: _usersList.length,
            itemBuilder: (context, position) => UserItem(_usersList[position]),
          ),
        ),
      ],
    );
  }

  void _removeTextFromSearchTextField() {
    this.widget._searchController.clear();
    this.widget._searchFocusNode.requestFocus();
  }
}
