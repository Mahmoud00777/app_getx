// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class UpdateTaskField extends StatelessWidget {
  String labelText;
  Icon? startIcon;
  Icon? endIcon;
  int? minLines;
  int? maxLines;
  bool? readOnly = false;
  Function()? onPress;
  TextInputType? keyboardType;
  TextEditingController? controller;

  UpdateTaskField({
    super.key,
    required this.labelText,
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
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        label: Text(labelText, style: TextStyle(fontSize: 14)),
        prefixIcon: startIcon,
        suffixIcon: endIcon,
        filled: true,
        fillColor: Colors.white,
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
