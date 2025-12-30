import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/common_list_model.dart';
import 'data_controller.dart';

class CommonListController extends GetxController {
  var isLoading = false.obs;
  final DataController dataController = Get.put(DataController());
  final Rx<CommonListModel> commonListModel = CommonListModel().obs;

  Future<void> fetchList(type) async {
    // type= Project, User
    isLoading.value = true;
    await dataController.loadMyData();
    String sid = dataController.mySavedSID.value;
    String url = dataController.mySavedBaseURL.value;

    try {
      var headers = {'Cookie': 'sid=$sid; user_image='};
      var response = await http.get(
        headers: headers,
        Uri.parse('$url/api/resource/$type'),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as Map<String, dynamic>;
        commonListModel.value = CommonListModel.fromJson(jsonData);

        // print("**** Common List Response ****");
        // print("Common List Controller: $jsonData");

        isLoading.value = false;
      } else {
        // Handle the error
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
    }
  }
}
