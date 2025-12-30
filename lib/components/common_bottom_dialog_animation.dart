import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/constants.dart';
import 'common_button.dart';
import 'common_text.dart';

class ModalHelperDialog {
  static void showCustomModalBottomSheetAnimation(
    BuildContext context,
    String animation,
    String subTitle,
    Function() onPress,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
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
                    Container(
                      height: 120,
                      width: 120,
                      color: transparent,
                      child: Lottie.asset(
                        animation,
                        fit: BoxFit.cover,
                        frameRate: FrameRate(120),
                      ),
                    ),
                    SizedBox(height: 10),
                    CommonText(
                      text: subTitle,
                      color: grey,
                      fontSize: 14,
                      textAlign: TextAlign.center,
                      weight: FontWeight.w300,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonButton(
                          height: 40,
                          width: 80,
                          text: "Okay",
                          onPress: onPress,
                        ),
                        // SizedBox(width: 10),
                        // CommonOutlineButton(
                        //   containerColor: white,
                        //   outlineColor: primaryAppColor,
                        //   shadowColor: transparent,
                        //   textColor: primaryAppColor,
                        //   height: 40,
                        //   width: 80,
                        //   text: "No",
                        //   onPress: onNoPress,
                        // ),
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
