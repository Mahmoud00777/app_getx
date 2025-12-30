import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'common_text.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final double? height;
  final double? width;
  final Color? color;
  final Color? shadowColor;
  final double? textSize;
  final Function() onPress;
  const CommonButton({
    super.key,
    required this.text,
    required this.onPress,
    this.color,
    this.shadowColor,
    this.height,
    this.width,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50.0,
      width: width ?? 200.0,
      // padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color ?? primaryAppColor,
            color?.withOpacity(0.5) ?? secondaryAppColor,
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: shadowColor?.withOpacity(0.2) ?? grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(2, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          // borderRadius: BorderRadius.circular(40.0),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          onTap: onPress,
          child: Center(
            child: CommonText(
              textAlign: TextAlign.center,
              text: " $text ",
              color: Colors.white,
              weight: FontWeight.w400,
              fontSize: textSize ?? 14,
            ),
          ),
        ),
      ),
    );
  }
}
