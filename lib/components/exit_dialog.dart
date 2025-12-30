import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:get/get.dart";

import "../utils/constants.dart";
import "common_button.dart";
import "common_text.dart";
import "common_outline_button.dart";

Future<bool?> exitDialog(BuildContext context) async {
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
            BoxShadow(
              blurRadius: 10,
              color: Colors.black26,
              spreadRadius: 5,
            ),
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
                  CommonText(text: "exit".tr, weight: FontWeight.w500, fontSize: 24, color: secondaryAppColor),
                  SizedBox(height: 10),
                  CommonText(text: "sureToExit".tr, color: grey, fontSize: 14, weight: FontWeight.w300),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonButton(
                        height: 40,
                        width: 80,
                        text: "yes".tr,
                        onPress: () {
                          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                        },
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
                        onPress: () {
                          Navigator.pop(context, false);
                        },
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      );
    },
  );
  // showDialog<bool>(
  //   context: context,
  //   builder: (context) {
  //     return AlertDialog(
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(10.0))),
  //       title: const Text('Exit'),
  //       content: const Text(
  //         'Are you sure you want to exit?',
  //         style: TextStyle(
  //           color: Colors.blueGrey,
  //           fontSize: 16.0,
  //         ),
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () {
  //             SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  //           },
  //           child: Text('Yes', style: boldText()),
  //         ),
  //         TextButton(
  //           onPressed: () {
  //             Navigator.pop(context, false);
  //           },
  //           child: Text('No', style: boldText()),
  //         ),
  //       ],
  //     );
  //   },
  // );
  return null;
}
