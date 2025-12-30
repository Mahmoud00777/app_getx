// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';
import 'common_button.dart';
import 'common_text.dart';
import 'common_outline_button.dart';

class CommonDialog extends StatelessWidget {
  final String title;
  final String subTitle;
  final Function() onPress;
  final Function() onNoPress;

  const CommonDialog({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onPress,
    required this.onNoPress,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: CommonText(
        text: title,
        color: secondaryAppColor,
        fontSize: 22,
        weight: FontWeight.w500,
      ),
      content: Text(subTitle),
      actions: [
        TextButton(
          onPressed: onPress,
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            foregroundColor: white,
            backgroundColor: secondaryAppColor,
            side: BorderSide(color: secondaryAppColor, width: 0.5),
          ),
          child: Text('Yes', style: TextStyle(color: white)),
        ),
        TextButton(
          onPressed: onNoPress,
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            side: BorderSide(color: secondaryAppColor, width: 0.2),
          ),
          child: Text('No', style: TextStyle(color: secondaryAppColor)),
        ),
      ],
    );
  }

  static Future<bool?> show(
    BuildContext context,
    String title,
    String subTitle,
    Function() onPress,
    Function() onNoPress,
  ) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => CommonDialog(
        title: title,
        subTitle: subTitle,
        onPress: onPress,
        onNoPress: onNoPress,
      ),
    );
  }
}

class ModalHelper {
  static void showCustomModalBottomSheet(
    BuildContext context,
    String title,
    String subTitle,
    Function() onPress,
    Function() onNoPress,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(blurRadius: 10, color: Colors.black26, spreadRadius: 5),
            ],
          ),
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          child: Material(
            color: white,
            child: Wrap(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CommonText(
                      text: title,
                      weight: FontWeight.w500,
                      fontSize: 24,
                      color: secondaryAppColor,
                    ),
                    SizedBox(height: 10),
                    CommonText(
                      text: subTitle,
                      color: grey,
                      fontSize: 14,
                      weight: FontWeight.w300,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonButton(
                          height: 40,
                          width: 80,
                          text: "yes".tr,
                          onPress: onPress,
                        ),
                        SizedBox(width: 10),
                        CommonOutlineButton(
                          containerColor: white,
                          outlineColor: primaryAppColor,
                          shadowColor: transparent,
                          textColor: primaryAppColor,
                          height: 40,
                          width: 80,
                          text: "no".tr,
                          onPress: onNoPress,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
