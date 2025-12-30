import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../utils/controllers/data_controller.dart';
import '../model/project_list_model.dart';

class ProjectListController extends GetxController {
  var isLoading = false.obs;
  final DataController dataController = Get.put(DataController());
  final Rx<ProjectListModel> projectListModel = ProjectListModel().obs;

  Future<void> fetchProject(sid, url) async {
    isLoading.value = true;
    try {
      var headers = {'Cookie': 'sid=$sid; user_image='};
      var response = await http.get(
        headers: headers,
        Uri.parse(
          '$url/api/method/erpnext_employee_hub.flutter_apis.project.get_projects',
        ),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as Map<String, dynamic>;
        projectListModel.value = ProjectListModel.fromJson(jsonData);

        print("**** Project List Response ****");
        print("Project List Controller: $jsonData");

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
