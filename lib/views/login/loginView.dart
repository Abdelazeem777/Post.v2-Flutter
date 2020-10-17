import 'package:flutter/material.dart';
import 'package:post/style/appColors.dart';
import 'package:post/utils/sizeConfig.dart';
import 'package:post/views/home/homeView.dart';
import 'package:post/views/login/loginViewModel.dart';
import 'package:post/views/signUp/signUpView.dart';
import 'package:post/views/widgets/stateless/animatedAppBarLogo.dart';
import 'package:post/views/widgets/stateful/emailTextFormField.dart';
import 'package:post/views/widgets/stateful/passwordTextFormField.dart';
import 'package:post/views/widgets/stateless/socialMediaLogin.dart';
import 'package:post/views/widgets/stateful/submitButton.dart';
import 'package:post/views/widgets/stateless/orLineSeparator.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

//TODO:add validation to login fields
class Login extends StatefulWidget {
  static const String routeName = '/Login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginViewModel _viewModel;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LoginViewModel(),
        child: Consumer<LoginViewModel>(
            builder: (BuildContext context, viewModel, Widget child) {
          this._viewModel = viewModel;
          return Scaffold(
              key: _viewModel.scaffoldKey,
              appBar: AnimatedAppBarLogo(),
              body: SafeArea(
                child: _createLoginPage(),
              ));
        }));
  }

  Widget _createLoginPage() {
    return ListView(
      children: [
        _createWelcomeText(),
        _createLoginForm(),
        OrLineSeparator(),
        SocialMediaLogin(
          context: context,
        ),
        _createDoNotHaveAccount()
      ],
    );
  }

  Widget _createWelcomeText() {
    return Container(
        margin: EdgeInsets.fromLTRB(
          32,
          SizeConfig.longScreen
              ? SizeConfig.safeBlockVertical * 3.5
              : SizeConfig.safeBlockVertical * 3,
          32,
          SizeConfig.longScreen
              ? SizeConfig.safeBlockVertical * 4
              : SizeConfig.safeBlockVertical * 2,
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          "Welcome Back,\nLogin",
          style: TextStyle(
              color: AppColors.PRIMARY_COLOR,
              fontSize: MediaQuery.of(context).textScaleFactor * 32),
        ));
  }

  Widget _createLoginForm() {
    return Form(
      key: _viewModel.formKey,
      autovalidateMode: _viewModel.autoValidate
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
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
          _createForgetPassword(),
          SubmitButton(
            text: "Login",
            onPressed: () => _viewModel.login(onLoginSuccess: _goToHomePage),
            busy: _viewModel.busy,
          ),
        ],
      ),
    );
  }

  Widget _createForgetPassword() {
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.only(right: 26),
      child: InkWell(
        child: Text(
          "Forget Password",
          style: TextStyle(color: AppColors.PRIMARY_COLOR, fontSize: 13),
        ),
        onTap: () {},
      ),
    );
  }

  _createDoNotHaveAccount() {
    return Container(
      margin: EdgeInsets.all(SizeConfig.safeBlockVertical * 3),
      alignment: Alignment.center,
      child: InkWell(
        child: Text.rich(
          TextSpan(
              text: "Don't have account? ",
              style: TextStyle(color: Colors.grey),
              children: [
                TextSpan(text: "Sign Up", style: TextStyle(color: Colors.black))
              ]),
        ),
        onTap: _goToSignUpPage,
      ),
    );
  }

  void _goToSignUpPage() => Navigator.of(context).pushNamed(SignUp.routeName);

  void _goToHomePage() => Navigator.of(context).popAndPushNamed(Home.routeName);
}
