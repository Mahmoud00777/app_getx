import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pos_app/utils/constants.dart';

import 'common_button.dart';

Future<void> checkConnectivity(BuildContext context) async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult.contains(ConnectivityResult.none)) {
    showNoConnectionDialog(context);
  }
}

Future<void> showNoConnectionDialog(context) async {
  // return Get.defaultDialog(
  //     barrierDismissible: true,
  //     onWillPop: () async {
  //       return false;
  //     },
  //     titlePadding: EdgeInsets.zero,
  //     title: "",
  //     content: Column(
  //       children: [
  //         Container(
  //             height: 120,
  //             width: 120,
  //             color: transparent,
  //             child: Stack(
  //               alignment: Alignment.center,
  //               children: [
  //                 Lottie.asset('assets/animations/no_wifi.json',
  //                     fit: BoxFit.cover, frameRate: FrameRate(120)),
  //                 Image(
  //                     height: 26,
  //                     image: AssetImage("assets/icons/no_wifi2.png")),
  //               ],
  //             )),
  //         Text(
  //           "Your device is not currently connected to the Internet",
  //           textAlign: TextAlign.center,
  //         )
  //       ],
  //     ),
  //     contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
  //     radius: 30,
  //     actions: [
  //       Column(
  //         children: [
  //           CommonButton(
  //             height: 40,
  //             width: 100,
  //             text: "Try Again",
  //             onPress: () {
  //               Get.back();
  //             },
  //           ),
  //         ],
  //       ),
  //     ]);
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: false,
    isDismissible: true,
    enableDrag: false,
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
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    color: transparent,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Lottie.asset(
                          'assets/animations/no_wifi.json',
                          fit: BoxFit.cover,
                          frameRate: FrameRate(120),
                        ),
                        Image(
                          height: 26,
                          image: AssetImage("assets/icons/no_wifi2.png"),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("noInternet".tr, textAlign: TextAlign.center),
                  ),
                  SizedBox(height: 20),
                  CommonButton(
                    height: 40,
                    width: 120,
                    text: "tryAgain".tr,
                    onPress: () {
                      Get.back();
                    },
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
