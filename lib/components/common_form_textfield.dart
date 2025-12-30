// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import '../utils/constants.dart';
import 'common_text.dart';

class CommonFormTextfield extends StatelessWidget {
  double? height;
  String labelText;
  String? hintText;
  String? initialValue;
  Icon? startIcon;
  Icon? endIcon;
  int? minLines;
  int? maxLines;
  bool? readOnly = false;
  bool? validate = true;
  Function()? onPress;
  Function(String)? onChanged;
  TextInputType? keyboardType;
  TextEditingController? controller;
  TextInputAction? textInputAction;
  Color? fillColor = white;
  CommonFormTextfield({
    super.key,
    required this.labelText,
    this.height,
    this.hintText,
    this.initialValue,
    this.startIcon,
    this.endIcon,
    this.minLines,
    this.maxLines,
    this.onPress,
    this.onChanged,
    this.readOnly,
    this.controller,
    this.keyboardType,
    this.validate,
    this.textInputAction,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 40,
      color: transparent,
      child: TextFormField(
        key: ValueKey(initialValue ?? controller?.text.trim()),
        keyboardType: keyboardType ?? TextInputType.emailAddress,
        minLines: minLines ?? 1,
        maxLines: maxLines ?? 1,
        readOnly: readOnly ?? false,
        initialValue: initialValue,
        controller: controller,
        onTap: onPress,
        textInputAction: textInputAction ?? TextInputAction.next,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          overflow: TextOverflow.fade,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor ?? white,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          label: CommonText(text: labelText, fontSize: 14),
          prefixIcon: startIcon,
          suffixIcon: endIcon,
          errorText: null,
          errorStyle: TextStyle(height: 0, fontSize: 0),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: statusRed, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.grey.shade600, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
          ),
          alignLabelWithHint: true,
        ),
        onChanged: onChanged,
        validator: validate == false
            ? null
            : (inputValue) {
                if (inputValue!.isEmpty) {
                  return "";
                }
                return null;
              },
      ),
    );
  }
}
