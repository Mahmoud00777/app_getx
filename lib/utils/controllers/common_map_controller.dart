import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'data_controller.dart';

class CommonMapController extends GetxController {
  var isLoading = false.obs;
  final DataController dataController = Get.put(DataController());
  // final Rx<CommonMapModel> model = CommonMapModel().obs;
  var data = [].obs;

  Future<void> fetchMap({
    String? search,
    String? type,
    String? ref,
    Map? filters,
    String? query,
  }) async {
    // type= Project, User
    isLoading.value = true;
    await dataController.loadMyData();
    String sid = dataController.mySavedSID.value;
    String url = dataController.mySavedBaseURL.value;
    String version = dataController.version.value;
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Cookie': 'sid=$sid; user_image=',
      };
      var body = json.encode({
        "txt": "$search",
        "page_length": 40,
        "doctype": type,
        "reference_doctype": ref,
        "query": query ?? "",
        "filters": filters ?? {},
      });
      // print("Body: $body");
      var response = await http.post(
        headers: headers,
        body: body,
        Uri.parse('$url/api/method/frappe.desk.search.search_link'),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as Map<String, dynamic>;
        // model.value = CommonMapModel.fromJson(jsonData);
        if (version == "13") {
          data.value = jsonData["results"];
        } else {
          data.value = jsonData["message"];
        }

        // print("**** Common Map Response ****");
        // print("Common Map Controller: $jsonData");

        isLoading.value = false;
      } else {
        // Handle the error
        data.value = [];
        print('Error: ${response.statusCode}');
        // Get.showSnackbar(gradientSnackbar("failure".tr, "Something went wrong!",
        // Colors.orange, Icons.warning_rounded));
      }
    } catch (e) {
      print('Error: $e');
      // Get.showSnackbar(
      //     gradientSnackbar("failure".tr, "$e", Colors.red, Icons.warning_rounded));
      isLoading.value = false;
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
