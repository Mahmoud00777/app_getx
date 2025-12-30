// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../utils/constants.dart';

class HalfRounded extends StatelessWidget {
  double? height;
  double? width;
  double? padding;
  double? margin;
  final Color? containerColor;
  final Widget? child;
  Color? shadowColor;
  bool? isOutline = false;
  Color? outlineColor;
  HalfRounded({
    super.key,
    this.width,
    this.height,
    this.containerColor,
    this.child,
    this.shadowColor,
    this.isOutline,
    this.outlineColor,
  });

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        gradient: isOutline ?? false
            ? LinearGradient(
                colors: [
                  outlineColor ?? secondaryAppColor,
                  outlineColor?.withOpacity(0.2) ??
                      secondaryAppColor.withOpacity(0.5),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            : LinearGradient(
                colors: [
                  containerColor ?? secondaryAppColor,
                  containerColor ?? secondaryAppColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
        boxShadow: [
          BoxShadow(
            color: shadowColor ?? Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 8),
          ),
        ],
      ),
      padding: EdgeInsets.all(0.9),
      child: Container(
        // height: height ?? 200,
        // width: width ?? 400,
        decoration: BoxDecoration(
          color: containerColor,
          // gradient: LinearGradient(
          //   colors: [Colors.lightBlueAccent, Colors.white],
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter
          // ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: child,
      ),
    );
  }
}
