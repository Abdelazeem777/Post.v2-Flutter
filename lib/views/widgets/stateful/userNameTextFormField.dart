import 'package:flutter/material.dart';
import 'package:post/style/appColors.dart';
import 'package:post/utils/validator.dart';
import 'package:post/views/widgets/stateless/mainTextFormField.dart';

class UserNameTextFormField extends MainTextFormField {
  UserNameTextFormField({
    @required FocusNode currentFocusNode,
    @required FocusNode nextFocusNode,
    @required TextEditingController currentController,
    EdgeInsetsGeometry margin,
  }) : super(
          currentController: currentController,
          currentFocusNode: currentFocusNode,
          nextFocusNode: nextFocusNode,
          validator: Validator.validateUserName,
          textCapitalization: TextCapitalization.words,
          icon: const Icon(
            Icons.person,
            color: AppColors.PRIMARY_COLOR,
            size: 21,
          ),
          hintText: "Name",
          keyboardType: TextInputType.name,
          margin: margin,
        );
}
