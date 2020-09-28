import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:post/enums/postTypeEnum.dart';
import 'package:post/models/comment.dart';
import 'package:post/models/post.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:post/style/appColors.dart';
import 'package:post/utils/sizeConfig.dart';
import 'package:post/views/widgets/stateful/interactiveViewerOverlay.dart';
import 'package:post/views/widgets/stateful/loadingAnimation.dart';
import 'package:post/views/widgets/stateful/videoPlayer.dart';

class PostItem extends StatefulWidget {
  Post post;
  PostItem(this.post);

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  Post _currentPost;
  TransformationController _interactiveTransformController;
  @override
  void initState() {
    super.initState();
    _interactiveTransformController = TransformationController();
  }

  Widget _createPostBasedOnItsType() {
    Widget postWidget;
    switch (_currentPost.postType) {
      case PostType.Text:
        postWidget = _createTextPost();
        break;
      case PostType.Image:
        postWidget = _createImagePost();
        break;
      case PostType.Video:
        postWidget = _createVideoPost();
        break;
      default:
        throw Exception("this post type is not defined");
    }
    return postWidget;
  }

  Widget _createTextPost() {
    return Container(
      color: AppColors.SECONDARY_COLOR,
      alignment: Alignment.center,
      height: SizeConfig.screenWidth,
      padding: EdgeInsets.all(16),
      child: AutoSizeText(
        _currentPost.postContent,
        presetFontSizes: [45, 40, 35, 30, 25, 20, 15],
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _createImagePost() {
    return SizedBox(
      height: SizeConfig.screenWidth,
      width: SizeConfig.screenWidth,
      child: InteractiveViewerOverlay(
        child: CachedNetworkImage(
          fit: BoxFit.contain,
          height: SizeConfig.screenWidth,
          imageUrl: _currentPost.postContent,
          progressIndicatorBuilder: (context, url, progress) => Center(
            child: CircularProgressIndicator(
              value: progress.totalSize != null
                  ? progress.downloaded / progress.totalSize
                  : null,
              valueColor: AlwaysStoppedAnimation(AppColors.SECONDARY_COLOR),
            ),
          ),
        ),
      ),
    );
  }

  Widget _createVideoPost() => CustomVideoPlayer(
        videoURL: _currentPost.postContent,
      );
  Widget _createTheNumberOfLikesCommentsReacts() {
    String likesNumber = _currentPost.reactsList.length.toString() + ' Likes';
    String commentsNumber = getCommentsAndRepliesNumber() + ' Comments';
    String sharesNumber = _currentPost.numberOfShares.toString() + ' Shares';
    return Container(
      padding: EdgeInsets.only(top: 3, bottom: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _createText(text: likesNumber),
          _createDot(),
          _createText(text: commentsNumber),
          _createDot(),
          _createText(text: sharesNumber),
        ],
      ),
    );
  }

  Widget _createText({String text}) {
    return Text(
      text,
      style: TextStyle(color: Colors.grey, fontSize: 14),
    );
  }

  Widget _createDot() {
    return Container(
      width: 4,
      height: 4,
      decoration: BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _currentPost = this.widget.post;
    return Column(
      children: [
        _createPostBasedOnItsType(),
        _createTheNumberOfLikesCommentsReacts(),
      ],
    );
  }

  String getCommentsAndRepliesNumber() {
    int count = 0;
    for (Comment comment in _currentPost.commentsList) {
      count++;
      count += comment.repliesList.length;
    }
    return count.toString();
  }
}
