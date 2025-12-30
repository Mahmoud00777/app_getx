import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../components/gradient_snackbar.dart';
import '../../../../utils/controllers/data_controller.dart';
import '../../../components/common_loading_dialog.dart';
import '../../../utils/constants.dart';

class DeleteRecordController extends GetxController {
  var isLoading = false.obs;

  final DataController dataController = Get.put(DataController());

  @override
  void onInit() {
    super.onInit();
    dataController.loadMyData();
  }

  //-----
  Future<void> deleteRecord({
    String? id,
    String? docType,
    required Function() onPressed,
  }) async {
    startLoading();
    String? sid = dataController.mySavedSID.value;
    String? url = dataController.mySavedBaseURL.value;
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Cookie': 'sid=$sid; user_image=',
      };
      var body = json.encode({"name": id, "doctype": docType});
      // print("Body: $body");
      var response = await http.post(
        headers: headers,
        body: body,
        Uri.parse('$url/api/method/frappe.client.delete'),
      );

      var jsonData = json.decode(response.body) as Map<String, dynamic>;
      // print(jsonData);
      if (response.statusCode == 200) {
        stopLoading();

        onPressed();
        Get.showSnackbar(
          gradientSnackbar(
            "success".tr,
            "recordDeleted".tr,
            green,
            Icons.check_circle_rounded,
          ),
        );
      } else if (response.statusCode == 409) {
        stopLoading();
        Get.showSnackbar(
          gradientSnackbar(
            "duplicateEntry".tr,
            "duplicateEntryMsg".tr,
            orange,
            Icons.warning_rounded,
          ),
        );
      } else if (response.statusCode == 403) {
        stopLoading();
        if (jsonData.containsKey("_error_message")) {
          Get.showSnackbar(
            gradientSnackbar(
              "noPermission".tr,
              "${jsonData["_error_message"] ?? jsonData}",
              Colors.orange,
              Icons.warning_rounded,
            ),
          );
        } else {
          sessionExpLite();
        }
      } else {
        print('Else Error: $jsonData');
        stopLoading();
        Get.showSnackbar(
          gradientSnackbar(
            "failure".tr,
            "$jsonData",
            red,
            Icons.cancel_outlined,
          ),
        );
      }
      update();
    } catch (e) {
      print('Catch Error: $e');
      stopLoading();
      Get.showSnackbar(
        gradientSnackbar(
          "failure".tr,
          "somethingWentWrong".tr,
          red,
          Icons.warning_rounded,
        ),
      );
    }
  }

  void startLoading() {
    showLoadingDialog("loading...");
  }

  void stopLoading() {
    Get.back();
  }
}
