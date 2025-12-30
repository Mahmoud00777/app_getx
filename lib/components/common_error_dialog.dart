import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:pos_app/components/common_text.dart';

import '../../../components/common_button.dart';
import '../../../utils/constants.dart';
import '../utils/html_parse.dart';

Future<void> CommonErrorDialog({
  required String title,
  required String message,
  String? animation,
}) async {
  Get.dialog(
    barrierDismissible: false,
    PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
      },
      child: Scaffold(
        backgroundColor: transparent,
        body: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: scaffoldBackground,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 8,
                  offset: Offset(2, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  height: 130,
                  width: 130,
                  animation ?? 'assets/animations/caution.json',
                  fit: BoxFit.cover,
                  frameRate: FrameRate(120),
                  repeat: false,
                ),
                const SizedBox(height: 5),
                CommonText(
                  text: title.tr,
                  textAlign: TextAlign.center,
                  weight: FontWeight.w500,
                  fontSize: 16,
                ),
                const SizedBox(height: 5),
                Center(
                  child: Container(
                    constraints: BoxConstraints(maxHeight: 120),
                    child: SingleChildScrollView(
                      child: CommonText(
                        text: parseHtml(message),
                        textAlign: TextAlign.center,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                CommonButton(
                  text: "okay".tr,
                  width: 120,
                  height: 40,
                  onPress: () async {
                    Get.back();
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
