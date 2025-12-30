// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../utils/constants.dart';

class AddPaymentField extends StatelessWidget {
  String labelText;
  String? hintText;
  Icon? startIcon;
  Icon? endIcon;
  int? minLines;
  int? maxLines;
  bool? readOnly = false;
  Function()? onPress;
  TextInputType? keyboardType;
  TextEditingController? controller;

  AddPaymentField({
    super.key,
    required this.labelText,
    this.hintText,
    this.startIcon,
    this.endIcon,
    this.minLines,
    this.maxLines,
    this.onPress,
    this.readOnly,
    this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType ?? TextInputType.emailAddress,
      minLines: minLines ?? 1,
      maxLines: maxLines ?? 1,
      readOnly: readOnly ?? false,
      controller: controller,
      onTap: onPress,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        overflow: TextOverflow.fade,
      ),
      decoration:
          InputDecoration.collapsed(
            filled: true,
            fillColor: white,
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 14),
          ).copyWith(
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            label: Text(labelText, style: TextStyle(fontSize: 14)),
            prefixIcon: startIcon,
            suffixIcon: endIcon,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.grey.shade600, width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
            ),
          ),
      validator: (inputValue) {
        if (inputValue!.isEmpty) {
          return "Enter $labelText";
        }
        return null;
      },
    );
  }
}
