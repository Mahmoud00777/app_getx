// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class HalfRoundedIconButton extends StatelessWidget {
  String text;
  Color? textColor;
  Color? outlineColor;
  Color? containerColor;
  double? height;
  double? width;
  String? image;
  final Function() onPress;
  HalfRoundedIconButton({
    super.key,
    required this.text,
    required this.onPress,
    this.containerColor,
    this.outlineColor,
    this.textColor,
    this.height,
    this.width,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50.0,
      width: width ?? 200.0,
      decoration: BoxDecoration(
        // gradient: LinearGradient(
        //   colors: [
        //     containerColor ?? primaryBlueApp,
        //     containerColor?.withOpacity(0.5) ?? primaryBlueApp.withOpacity(0.5)
        //   ],
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        // ),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: outlineColor ?? Colors.black, width: 2),
        color: containerColor ?? Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          // borderRadius: BorderRadius.circular(40.0),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          onTap: onPress,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                  filterQuality: FilterQuality.high,
                  width: 30,
                  // height: 30,
                  image: AssetImage(image ?? "assets/icons/arrow_right.png"),
                  fit: BoxFit.cover),
              SizedBox(width: 5),
              Text(
                text,
                style: TextStyle(
                  color: textColor ?? Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
