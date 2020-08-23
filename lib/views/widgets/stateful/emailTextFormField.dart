import 'package:flutter/material.dart';
import 'package:post/style/appColors.dart';
import 'package:post/utils/validator.dart';
import 'package:post/views/widgets/stateless/mainTextFormField.dart';

class EmailTextFormField extends MainTextFormField {
  EmailTextFormField({
    @required FocusNode currentFocusNode,
    @required FocusNode nextFocusNode,
    @required TextEditingController currentController,
    EdgeInsetsGeometry margin,
  }) : super(
          currentController: currentController,
          currentFocusNode: currentFocusNode,
          nextFocusNode: nextFocusNode,
          validator: Validator.validateEmail(),
          icon: const Icon(
            Icons.email,
            color: AppColors.PRIMARY_COLOR,
            size: 21,
          ),
          hintText: "Email Address",
          keyboardType: TextInputType.emailAddress,
          margin: margin,
        );
}
