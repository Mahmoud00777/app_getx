import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:pos_app/app/dashboard/view/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/common_text.dart';
import '../../../components/gradient_snackbar.dart';
import '../../../utils/constants.dart';
import '../../../utils/controllers/data_controller.dart';

class LoginController extends GetxController {
  final DataController dataController = Get.put(DataController());

  var isLoading = false.obs;

  //////////////////////// fetchLogin Function ////////////////////////
  ///////////////////////////////////////////////////////////////////////////
  Future<void> fetchLogin(
    String? protocol,
    String? baseURL,
    String? username,
    String? password,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    startLoading();

    try {
      var response = await http.get(
        Uri.parse(
          '$protocol://$baseURL/api/method/mobile_haifa.flutter_apis.authentication.login?usr=$username&pwd=${Uri.encodeComponent(password.toString())}',
        ),
      );
      // print("This is my URL: $protocol://$baseURL");
      // print("This is my Username: $username");
      // print("This is my Password1: $password");
      // print("This is my Password2: ${Uri.encodeComponent(password.toString())}");
      var jsonData = json.decode(response.body) as Map<String, dynamic>;
      print("**** LoginController Response ****");
      print("Login Controller: $jsonData");
      print("Login Controller: ${jsonData["message"]["success"]}");

      //
      //
      print(response.statusCode);
      if (response.statusCode == 200) {
        if (jsonData["message"]["success"] == true) {
          print("loggedInStatus: true");
          await prefs.setBool('loggedInStatus', true);
          await prefs.setString('savedURL', "$baseURL");
          await prefs.setString('baseUrl', "$protocol://$baseURL");
          await prefs.setString(
            'SID',
            "${jsonData["message"]["data"]["sid"] ?? ""}",
          );
          await prefs.setString(
            'name',
            jsonData["message"]["data"]["name"].toString().trim().toLowerCase(),
          );
          await prefs.setString(
            'username',
            "${jsonData["message"]["data"]["username"] ?? "-"}",
          );
          await prefs.setString(
            'email',
            "${jsonData["message"]["data"]["email"] ?? ""}",
          );
          await prefs.setString('fullName', "${jsonData["full_name"] ?? ""}");
          await prefs.setString(
            'emp',
            "${jsonData["message"]["data"]["employee"] ?? ""}",
          );
          await prefs.setString(
            'userImage',
            "${jsonData["message"]["data"]["user_image"] ?? ""}",
          );
          await prefs.setString(
            'version',
            "${jsonData["message"]["version"] ?? "0"}",
          );
          // if (jsonData["message"].containsKey("user") && dataController.syncLang.value == true) {
          //   findLanguage("${jsonData["message"]["user"]["language"] ?? ""}");
          // }
          stopLoading();
          if (jsonData["message"]["data"]["employee"].toString() != "null") {
            Get.showSnackbar(
              gradientSnackbar(
                "success".tr,
                "${jsonData["message"]["message"] ?? "loggedIn".tr}",
                green,
                Icons.check_circle_rounded,
              ),
            );
            await dataController.loadMyData();
            // await subscribeController.getSubsribe(
            //   dataController.mySavedSID.value,
            //   dataController.mySavedBaseURL.value,
            //   dataController.mySavedEmail.value,
            //   dataController.myDeviceToken.value,
            //   false,
            // );
            await Get.off(() => DashboardScreen());
          } else {
            Get.showSnackbar(
              gradientSnackbar(
                "noEmployee".tr,
                "noEmployeeMsg".tr,
                red,
                Icons.warning_rounded,
              ),
            );
          }
        } else {
          stopLoading();
          Get.showSnackbar(
            gradientSnackbar(
              "failure".tr,
              "${jsonData["message"]["message"] ?? jsonData}",
              red,
              Icons.warning_rounded,
            ),
          );
        }
      } else {
        stopLoading();
        Get.showSnackbar(
          gradientSnackbar(
            "failure".tr,
            "${jsonData["message"] ?? jsonData}",
            red,
            Icons.warning_rounded,
          ),
        );
      }
    } catch (e) {
      print('Catch Error: $e');
      if (e.toString() == "Connection refused") {
        stopLoading();
        Get.showSnackbar(
          gradientSnackbar(
            "invalidURL".tr,
            "enterValidURL".tr,
            orange,
            CupertinoIcons.globe,
          ),
        );
      } else if (e.toString().contains("Failed host lookup")) {
        stopLoading();
        Get.showSnackbar(
          gradientSnackbar(
            "invalidURL".tr,
            "enterValidURL".tr,
            orange,
            CupertinoIcons.globe,
          ),
        );
      } else {
        print(e);
        stopLoading();
        Get.showSnackbar(
          gradientSnackbar("failure".tr, "$e", orange, CupertinoIcons.globe),
        );
      }
    }
  }

  //
  //===== Custom Functions
  //

  void showLoadingDialog() {
    Get.dialog(
      // barrierColor: black.withOpacity(0.2),
      Scaffold(
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
                  // width: 80,
                  frameRate: FrameRate(120),
                ),
                CommonText(text: "loading...".tr, fontSize: 16),
                SizedBox(width: 30),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  void startLoading() {
    isLoading.value = true;
    showLoadingDialog();
  }

  void stopLoading() {
    isLoading.value = false;
    Get.back();
  }
}

Future<Map<String, dynamic>?> findLanguage(String? serverLanguage) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (serverLanguage == null) return null;

  try {
    final languageData = langList.firstWhere(
      (lang) => lang['code'] == serverLanguage,
    );
    // print("Server Language: $languageData");
    await prefs.setString('langCode', languageData["code"]);
    await prefs.setString('langCountry', languageData["country"]);
    var locale = Locale(languageData["code"], languageData["country"]);
    Get.updateLocale(locale);
    return languageData;
  } catch (e) {
    // print("Server Language: Not Found!");
    return null;
  }
}
