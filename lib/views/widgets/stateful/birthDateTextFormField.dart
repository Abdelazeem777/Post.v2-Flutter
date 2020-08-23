import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:post/style/appColors.dart';
import 'package:post/utils/sizeConfig.dart';
import 'package:post/utils/validator.dart';

class BirthDateTextFormField extends StatefulWidget {
  final FocusNode currentFocusNode, nextFocusNode;
  final TextEditingController currentController;
  EdgeInsetsGeometry margin;

  BirthDateTextFormField({
    @required this.currentFocusNode,
    @required this.nextFocusNode,
    @required this.currentController,
    this.margin,
  });

  @override
  _BirthDateTextFormFieldState createState() => _BirthDateTextFormFieldState();
}

class _BirthDateTextFormFieldState extends State<BirthDateTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: this.widget.margin ??
          EdgeInsets.fromLTRB(
            16,
            SizeConfig.safeBlockVertical * 3,
            16,
            0,
          ),
      child: TextFormField(
        focusNode: this.widget.currentFocusNode,
        controller: this.widget.currentController,
        maxLines: 1,
        style: TextStyle(fontSize: 14),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          hintText: "BirthDate",
          prefixIcon: const Icon(
            Icons.calendar_today,
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
            onTap: _selectDateFromCalender,
            child: Icon(
              Icons.edit,
              size: 21,
              color: AppColors.PRIMARY_COLOR,
            ),
          ),
        ),
        validator: Validator.validateBirthDate(),
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(this.widget.nextFocusNode);
        },
        readOnly: this.widget.currentController.text.isEmpty,
      ),
    );
  }

  void _selectDateFromCalender() => showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      ).then((selectedDate) {
        if (selectedDate != null)
          setState(() => this.widget.currentController.text =
              selectedDate.toLocal().toString().split(' ')[0]);
      });
}
