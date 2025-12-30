// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import '../utils/constants.dart';
import 'common_text.dart';

class BottomsheetTextfield extends StatelessWidget {
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
  BottomsheetTextfield({
    super.key,
    required this.labelText,
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
      height: 40,
      margin: EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: fillColor ?? white,
      ),
      child: TextFormField(
        key: ValueKey(initialValue ?? controller?.text.trim()),
        keyboardType: keyboardType ?? TextInputType.emailAddress,
        minLines: minLines ?? 1,
        maxLines: maxLines ?? 1,
        readOnly: readOnly ?? false,
        initialValue: initialValue,
        controller: controller,
        onTap: onPress,
        textInputAction: textInputAction ?? TextInputAction.done,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          overflow: TextOverflow.fade,
        ),
        decoration:
            InputDecoration.collapsed(
              filled: true,
              fillColor: fillColor ?? white,
              hintText: hintText,
              hintStyle: TextStyle(fontSize: 12),
            ).copyWith(
              contentPadding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 10,
              ),
              label: CommonText(text: labelText, fontSize: 12),
              prefixIcon: startIcon,
              suffixIcon: endIcon,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                borderSide: BorderSide(color: Colors.grey.shade600, width: 2.0),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                borderSide: BorderSide(color: statusRed, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
              ),
              alignLabelWithHint: true,
            ),
        onChanged: onChanged,
        validator: validate == false
            ? null
            : (inputValue) {
                if (inputValue!.isEmpty) {
                  return "Enter $labelText";
                }
                return null;
              },
      ),
    );
  }
}
