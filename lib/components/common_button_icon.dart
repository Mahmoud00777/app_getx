import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CommonButtonIcon extends StatelessWidget {
  final IconData icon;
  final double? height;
  final double? width;
  final Color? color;
  final Color? shadowColor;
  final Color? iconColor;
  final Function() onPress;
  const CommonButtonIcon({
    super.key,
    required this.icon,
    required this.onPress,
    this.color,
    this.shadowColor,
    this.iconColor,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50.0,
      width: width ?? 200.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color ?? secondaryAppColor,
            color?.withOpacity(0.5) ?? secondaryAppColor.withOpacity(0.5),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        // borderRadius: BorderRadius.circular(20.0),
        borderRadius: BorderRadius.all(Radius.circular(20)),
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
          child: Center(child: Icon(icon, color: iconColor ?? primaryAppColor)),
        ),
      ),
    );
  }
}
