import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/app/auth/view/info_screen.dart';
import 'package:pos_app/components/common_text.dart';

import '../../../components/common_button.dart';
import '../../../components/common_outline_button.dart';
import '../../../utils/constants.dart';

Future<void> showInfoDialog() async {
  // await showOutOfRangeDialog();
  Get.dialog(
    barrierDismissible: true,
    Scaffold(
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
              SizedBox(height: 10),
              Image(
                height: 80,
                width: 80,
                image: AssetImage("assets/icons/badge.png"),
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
              CommonText(
                text: "enjoyingApp?".tr,
                textAlign: TextAlign.center,
                weight: FontWeight.w600,
                fontSize: 16,
              ),
              SizedBox(height: 10),
              CommonText(
                text: "infoMsg".tr,
                textAlign: TextAlign.center,
                weight: FontWeight.w300,
                fontSize: 14,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonOutlineButton(
                    containerColor: white,
                    outlineColor: primaryAppColor,
                    shadowColor: transparent,
                    textColor: primaryAppColor,
                    width: 120,
                    height: 40,
                    text: "no".tr,
                    onPress: () {
                      Get.back();
                    },
                  ),
                  SizedBox(width: 10),
                  CommonButton(
                    text: "yes".tr,
                    width: 120,
                    height: 40,
                    onPress: () async {
                      Get.back();
                      Get.to(() => InfoScreen());
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ),
  );
}
