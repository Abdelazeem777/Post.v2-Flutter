import 'package:flutter/material.dart';
import 'package:post/style/appColors.dart';
import 'package:post/utils/sizeConfig.dart';
import 'package:post/views/home/homeView.dart';
import 'package:post/views/login/loginView.dart';
import 'package:post/views/signUp/signUpViewModel.dart';
import 'package:post/views/widgets/stateful/birthDateTextFormField.dart';
import 'package:post/views/widgets/stateful/emailTextFormField.dart';
import 'package:post/views/widgets/stateful/passwordTextFormField.dart';
import 'package:post/views/widgets/stateful/phoneNumberTextFormField.dart';
import 'package:post/views/widgets/stateful/submitButton.dart';
import 'package:post/views/widgets/stateful/userNameTextFormField.dart';
import 'package:post/views/widgets/stateless/animatedAppBarLogo.dart';
import 'package:post/views/widgets/stateless/orLineSeparator.dart';
import 'package:post/views/widgets/stateless/socialMediaLogin.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  static const String routeName = '/SignUp';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  SignUpViewModel _viewModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SignUpViewModel(),
        child: Consumer<SignUpViewModel>(
          builder: (BuildContext context, viewModel, Widget child) {
            this._viewModel = viewModel;
            return Scaffold(
              key: _viewModel.scaffoldKey,
              appBar: AnimatedAppBarLogo(),
              body: SafeArea(
                child: _createSignUpPage(),
              ),
            );
          },
        ));
  }

  Widget _createSignUpPage() {
    return ListView(
      children: [
        _createTitleText(),
        _createSignUpForm(),
        OrLineSeparator(),
        SocialMediaLogin(),
        _createAlreadyHaveAccount()
      ],
    );
  }

  Widget _createTitleText() {
    return Container(
        margin: EdgeInsets.fromLTRB(
          24,
          SizeConfig.longScreen
              ? SizeConfig.safeBlockVertical * 1.75
              : SizeConfig.safeBlockVertical * 1.5,
          24,
          SizeConfig.longScreen ? SizeConfig.safeBlockVertical * 2 : 0,
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          "Create an account",
          style: TextStyle(
              color: AppColors.PRIMARY_COLOR,
              fontSize: MediaQuery.of(context).textScaleFactor * 21),
        ));
  }

  Widget _createSignUpForm() {
    return Form(
        key: _viewModel.formKey,
        autovalidateMode: _viewModel.autoValidate
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            UserNameTextFormField(
                currentFocusNode: _viewModel.userNameFocusNode,
                nextFocusNode: _viewModel.phoneNumberFocusNode,
                currentController: _viewModel.userNameController,
                margin: EdgeInsets.fromLTRB(
                    16, SizeConfig.safeBlockVertical * 1.5, 16, 0)),
            PhoneNumberTextFormField(
              currentFocusNode: _viewModel.phoneNumberFocusNode,
              nextFocusNode: _viewModel.birthDateFocusNode,
              currentController: _viewModel.phoneNumberController,
            ),
            BirthDateTextFormField(
              currentFocusNode: _viewModel.birthDateFocusNode,
              nextFocusNode: _viewModel.emailFocusNode,
              currentController: _viewModel.birthDateController,
            ),
            EmailTextFormField(
              currentFocusNode: _viewModel.emailFocusNode,
              nextFocusNode: _viewModel.passwordFocusNode,
              currentController: _viewModel.emailController,
            ),
            PasswordTextFormField(
              currentFocusNode: _viewModel.passwordFocusNode,
              nextFocusNode: null,
              currentController: _viewModel.passwordController,
            ),
            //_createAgreeAllTermsCheckBox(),
            SubmitButton(
              text: "Sign Up",
              onPressed: () =>
                  _viewModel.signUp(onSignUpSuccess: _goToHomePage),
              busy: _viewModel.busy,
            ),
          ],
        ));
  }

  /* Widget _createAgreeAllTermsCheckBox() {
                    return Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(right: 26),
                      child: Row(
                        children: [
                          Checkbox(
                            value: false,
                            onChanged: (_) {},
                          ),
                          InkWell(
                            child: Text(
                              "I agree with all terms & conditions",
                              style: TextStyle(color: AppColors.PRIMARY_COLOR),
                            ),
                            onTap: () => showDialog(
                              context: context,
                              child: AlertDialog(
                                content: Text("All terms & conditions 😂"),
                                actions: [
                                  SubmitButton(
                                    busy: false,
                                    onPressed: () => Navigator.of(context).pop(null),
                                    text: "Okay",
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  } */

  _createAlreadyHaveAccount() {
    return Container(
      margin: EdgeInsets.all(SizeConfig.safeBlockVertical * 2.5),
      alignment: Alignment.center,
      child: InkWell(
        child: Text.rich(
          TextSpan(
              text: "Already have account? ",
              style: TextStyle(color: Colors.grey),
              children: [
                TextSpan(text: "Login", style: TextStyle(color: Colors.black))
              ]),
        ),
        onTap: _goToLoginPage,
      ),
    );
  }

  void _goToLoginPage() => Navigator.of(context).pushNamed(Login.routeName);

  void _goToHomePage() => Navigator.of(context).popAndPushNamed(Home.routeName);
}
