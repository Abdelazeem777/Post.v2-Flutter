import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:post/services/currentUser.dart';
import 'package:post/style/appColors.dart';
import 'package:post/utils/sizeConfig.dart';
import 'package:post/utils/validator.dart';
import 'package:post/views/editPofilePage/editProfilePageViewModel.dart';
import 'package:post/views/login/loginView.dart';
import 'package:post/views/widgets/stateful/userProfilePicture.dart';

class EditProfilePage extends StatefulWidget {
  static const String routeName = '/editProfilePage';
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _viewModel = EditProfilePageViewModel();
  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => _viewModel,
        child: Scaffold(
          key: _viewModel.scaffoldKey,
          appBar: _createAppBar(),
          body: _createEditPageBody(),
        ));
  }

  Widget _createAppBar() {
    return AppBar(
        shadowColor: AppColors.SECONDARY_COLOR,
        title: Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).canvasColor,
        iconTheme: IconThemeData(color: AppColors.PRIMARY_COLOR),
        leading: CloseButton(
          color: Colors.grey[600],
          onPressed: _goBackToProfileTab,
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.check,
                color: AppColors.PRIMARY_COLOR,
              ),
              onPressed: () =>
                  _viewModel.updateUserData(onSuccess: _goBackToProfileTab))
        ]);
  }

  Widget _createEditPageBody() {
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
            margin: EdgeInsets.all(16),
            alignment: Alignment.topCenter,
            height: SizeConfig.screenHeight - 110,
            child: Column(
              children: [
                const _CurrentUserProfilePicWithEditButton(),
                const _EditProfileForm(),
                Spacer(),
                _DeleteAccountButton(
                  onPressed: showAlertDialog,
                )
              ],
            ))
      ],
    );
  }

  void showAlertDialog() => showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Delete this account?'),
          content: const Text(
              'If you delete this account, you won\'t be able to login again using this account and your data will be deleted.'),
          actions: [
            _CancelButton(context: context),
            _Confirm(
              onPressed: () =>
                  _viewModel.deleteAccount(onSuccess: _goToLoginPage),
            )
          ],
        ),
      );

  void _goBackToProfileTab() => Navigator.of(context).pop();
  void _goToLoginPage() =>
      Navigator.of(context).popAndPushNamed(Login.routeName);
}

class _EditProfileForm extends StatelessWidget {
  const _EditProfileForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<EditProfilePageViewModel>(context);
    return Form(
      key: _viewModel.formKey,
      autovalidateMode: _viewModel.autoValidate
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: Column(
        children: [
          _EditProfileTextField(
            currentController: _viewModel.userNameController,
            currentFocusNode: _viewModel.userNameFocusNode,
            nextFocusNode: _viewModel.bioFocusNode,
            label: 'User Name',
          ),
          _EditProfileTextField(
            currentController: _viewModel.bioController,
            currentFocusNode: _viewModel.bioFocusNode,
            label: 'Bio',
          ),
        ],
      ),
    );
  }
}

class _EditProfileTextField extends StatelessWidget {
  final FocusNode currentFocusNode, nextFocusNode;
  final TextEditingController currentController;
  final String label;

  const _EditProfileTextField({
    Key key,
    @required this.currentFocusNode,
    this.nextFocusNode,
    @required this.currentController,
    @required this.label,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: currentFocusNode,
      controller: currentController,
      maxLines: 1,
      style: TextStyle(fontSize: 14),
      cursorColor: AppColors.PRIMARY_COLOR,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppColors.PRIMARY_COLOR),
        focusedBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.PRIMARY_COLOR,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.PRIMARY_COLOR,
          ),
        ),
      ),
      validator: Validator.validateUserName,
      onFieldSubmitted: (String value) {
        FocusScope.of(context).requestFocus(nextFocusNode);
      },
    );
  }
}

class _CurrentUserProfilePicWithEditButton extends StatelessWidget {
  const _CurrentUserProfilePicWithEditButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<EditProfilePageViewModel>(context);
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
          width: 150,
          height: 150,
          child: Stack(
            overflow: Overflow.visible,
            children: [
              Hero(
                tag: "CurrentUserProfilePic",
                child: Material(
                  type: MaterialType.transparency,
                  child: UserProfilePicture(
                    imageURL: CurrentUser().userProfilePicURL,
                  ),
                ),
              ),
              Positioned(
                  bottom: -6,
                  right: -8,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.white),
                      shape: MaterialStateProperty.resolveWith(
                          (states) => CircleBorder()),
                    ),
                    child: Icon(
                      Icons.edit,
                      color: AppColors.PRIMARY_COLOR,
                    ),
                    onPressed: _viewModel.chooseImage,
                  ))
            ],
          )),
    );
  }
}

class _DeleteAccountButton extends StatelessWidget {
  final Function onPressed;
  const _DeleteAccountButton({
    Key key,
    @required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          "Delete Account",
          style: TextStyle(fontSize: 16),
        ),
        style: ButtonStyle(
            backgroundColor:
                MaterialStateColor.resolveWith((states) => Colors.red)),
      ),
    );
  }
}

class _Confirm extends StatelessWidget {
  final Function onPressed;

  const _Confirm({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('Confirm'),
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith((_) => Colors.red)),
    );
  }
}

class _CancelButton extends StatelessWidget {
  const _CancelButton({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text('Cancel'),
      onPressed: () => Navigator.of(context).pop(),
      style: ButtonStyle(
          foregroundColor:
              MaterialStateColor.resolveWith((_) => Colors.grey[700])),
    );
  }
}
