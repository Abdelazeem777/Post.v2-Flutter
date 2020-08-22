import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:post/style/appColors.dart';
import 'package:post/utils/sizeConfig.dart';
import 'package:post/utils/validator.dart';

class PasswordTextFormField extends StatefulWidget {
  final FocusNode currentFocusNode, nextFocusNode;
  final TextEditingController currentController;

  PasswordTextFormField({
    @required this.currentFocusNode,
    @required this.nextFocusNode,
    @required this.currentController,
  });

  @override
  _PasswordTextFormFieldState createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool _obscureTextLogin = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: EdgeInsets.fromLTRB(
        16,
        SizeConfig.safeBlockVertical * 3,
        16,
        SizeConfig.safeBlockVertical * 1.5,
      ),
      child: TextFormField(
        focusNode: this.widget.currentFocusNode,
        controller: this.widget.currentController,
        obscureText: _obscureTextLogin,
        maxLines: 1,
        style: TextStyle(fontSize: 14),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          hintText: "Password",
          prefixIcon: const Icon(
            Icons.lock,
            color: AppColors.PRIMARY_COLOR,
            size: 21,
          ),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.PRIMARY_COLOR,
              width: 1,
            ),
            borderRadius: const BorderRadius.all(
              const Radius.circular(50),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.PRIMARY_COLOR,
              width: 1,
            ),
            borderRadius: const BorderRadius.all(
              const Radius.circular(50),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 1,
            ),
            borderRadius: const BorderRadius.all(
              const Radius.circular(50),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 1,
            ),
            borderRadius: const BorderRadius.all(
              const Radius.circular(50),
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: _toggleLogin,
            child: Icon(
              _obscureTextLogin
                  ? FontAwesomeIcons.eye
                  : FontAwesomeIcons.eyeSlash,
              size: 18,
              color: AppColors.PRIMARY_COLOR,
            ),
          ),
        ),
        validator: Validator.validatePassword(),
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(this.widget.nextFocusNode);
        },
      ),
    );
  }

  _toggleLogin() => setState(() {
        _obscureTextLogin = !_obscureTextLogin;
      });
}
