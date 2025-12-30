import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:pos_app/components/common_text.dart';
import '../../../utils/constants.dart';

Future<void> showLoadingDialog(String? text) async {
  String? loadingText = text ?? "Loading...";
  await onLoading(loadingText);
}

// show loading widget
Future<void> onLoading(loadingText) async {
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
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 10),
                Lottie.asset(
                  'assets/animations/loading.json',
                  height: 80,
                  frameRate: FrameRate(120),
                ),
                CommonText(text: "$loadingText".tr, fontSize: 16),
                SizedBox(width: 30),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

// Offline
Future<void> closeLoadingDialog() async {
  Get.back();
}
