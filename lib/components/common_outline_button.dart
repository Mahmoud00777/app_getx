// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'common_text.dart';

class CommonOutlineButton extends StatelessWidget {
  String text;
  Color? textColor;
  Color? outlineColor;
  Color? containerColor;
  Color? shadowColor;
  double? height;
  double? width;
  double? textSize;
  final Function() onPress;
  CommonOutlineButton({
    super.key,
    required this.text,
    required this.onPress,
    this.containerColor,
    this.outlineColor,
    this.shadowColor,
    this.textColor,
    this.height,
    this.width,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50.0,
      width: width ?? 200.0,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: outlineColor ?? Colors.black, width: 1),
        color: containerColor ?? Colors.white,
        boxShadow: [
          BoxShadow(
            color: shadowColor ?? Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          onTap: onPress,
          child: Center(
            child: CommonText(
              text: text,
              color: textColor ?? Colors.black,
              weight: FontWeight.w400,
              fontSize: textSize ?? 14,
            ),
          ),
        ),
      ),
    );
  }
}
