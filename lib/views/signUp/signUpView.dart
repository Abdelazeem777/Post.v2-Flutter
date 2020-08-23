import 'package:flutter/material.dart';
import 'package:post/style/appColors.dart';
import 'package:post/utils/sizeConfig.dart';
import 'package:post/views/login/loginView.dart';
import 'package:post/views/widgets/stateful/birthDateTextFormField.dart';
import 'package:post/views/widgets/stateful/emailTextFormField.dart';
import 'package:post/views/widgets/stateful/passwordTextFormField.dart';
import 'package:post/views/widgets/stateful/phoneNumberTextFormField.dart';
import 'package:post/views/widgets/stateful/submitButton.dart';
import 'package:post/views/widgets/stateful/userNameTextFormField.dart';
import 'package:post/views/widgets/stateless/animatedAppBarLogo.dart';
import 'package:post/views/widgets/stateless/orLineSeparator.dart';
import 'package:post/views/widgets/stateless/socialMediaLogin.dart';

class SignUp extends StatefulWidget {
  static const String routeName = '/SignUp';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FocusNode userNameFocusNode = FocusNode();
  final FocusNode birthDateFocusNode = FocusNode();
  final FocusNode phoneNumberFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  TextEditingController userNameController = new TextEditingController();
  TextEditingController birthDateController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  Widget _createLoginPage() {
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
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        UserNameTextFormField(
            currentFocusNode: userNameFocusNode,
            nextFocusNode: phoneNumberFocusNode,
            currentController: userNameController,
            margin: EdgeInsets.fromLTRB(
                16, SizeConfig.safeBlockVertical * 1.5, 16, 0)),
        PhoneNumberTextFormField(
          currentFocusNode: phoneNumberFocusNode,
          nextFocusNode: birthDateFocusNode,
          currentController: phoneNumberController,
        ),
        BirthDateTextFormField(
          currentFocusNode: birthDateFocusNode,
          nextFocusNode: emailFocusNode,
          currentController: birthDateController,
        ),
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
        //_createAgreeAllTermsCheckBox(),
        SubmitButton(
          text: "Sign Up",
          onPressed: () {},
          busy: false,
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
        onTap: goToLoginPage,
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

  goToLoginPage() => Navigator.of(context).pushNamed(Login.routeName);
}
