import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../components/gradient_snackbar.dart';
import '../../../../utils/controllers/data_controller.dart';

class CommonDetailController extends GetxController {
  var isLoading = false.obs;
  final DataController dataController = Get.put(DataController());
  RxMap data = {}.obs;

  @override
  void onInit() {
    super.onInit();
    dataController.loadMyData();
  }

  Future<void> getRecord({String? id, String? type}) async {
    isLoading.value = true;
    String? sid = dataController.mySavedSID.value;
    String? url = dataController.mySavedBaseURL.value;
    try {
      var headers = {'Content-Type': 'application/json', 'Cookie': 'sid=$sid; user_image='};

      var response = await http.get(
        headers: headers,
        Uri.parse('$url/api/resource/$type/$id'),
      );

      var jsonData = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        data.value = jsonData["data"] ?? {};
        // print("data: $data");
      } else {
        data.clear();
        Get.showSnackbar(gradientSnackbar(
          "failure".tr,
          "${jsonData["exception"] ?? jsonData}",
          Colors.orange,
          Icons.warning_rounded,
        ));
      }
    } catch (e) {
      data.clear();
      print("Catch Error $e");
    } finally {
      isLoading.value = false;
    }
  }
}
