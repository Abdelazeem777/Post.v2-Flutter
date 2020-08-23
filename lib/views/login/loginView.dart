import 'package:flutter/material.dart';
import 'package:post/style/appColors.dart';
import 'package:post/utils/sizeConfig.dart';
import 'package:post/views/signUp/signUpView.dart';
import 'package:post/views/widgets/stateless/animatedAppBarLogo.dart';
import 'package:post/views/widgets/stateful/emailTextFormField.dart';
import 'package:post/views/widgets/stateful/passwordTextFormField.dart';
import 'package:post/views/widgets/stateless/socialMediaLogin.dart';
import 'package:post/views/widgets/stateful/submitButton.dart';
import 'package:post/views/widgets/stateless/orLineSeparator.dart';

class Login extends StatefulWidget {
  static const String routeName = '/Login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  Widget _createLoginPage() {
    return ListView(
      children: [
        _createWelcomeText(),
        _createLoginForm(),
        OrLineSeparator(),
        SocialMediaLogin(),
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
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        EmailTextFormField(
          currentFocusNode: emailFocusNode,
          nextFocusNode: passwordFocusNode,
          currentController: emailController,
        ),
        PasswordTextFormField(
          currentFocusNode: passwordFocusNode,
          nextFocusNode: null,
          currentController: passwordController,
        ),
        _createForgetPassword(),
        SubmitButton(
          text: "Login",
          onPressed: () {},
          busy: false,
        ),
      ],
    ));
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
        onTap: goToSignUpPage,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AnimatedAppBarLogo(),
      body: SafeArea(
        child: _createLoginPage(),
      ),
    );
  }

  goToSignUpPage() => Navigator.of(context).pushNamed(SignUp.routeName);
}
