import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../utils/controllers/data_controller.dart';
import '../model/company_list_model.dart';

class CompanyListController extends GetxController {
  var isLoading = false.obs;
  final DataController dataController = Get.put(DataController());
  final Rx<CompanyListModel> companyListModel = CompanyListModel().obs;

  Future<void> fetchCompany(sid, url) async {
    isLoading.value = true;
    try {
      var headers = {'Cookie': 'sid=$sid; user_image='};
      var response = await http.get(
        headers: headers,
        Uri.parse(
          '$url/api/method/erpnext_employee_hub.flutter_apis.company.get_companies',
        ),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as Map<String, dynamic>;
        companyListModel.value = CompanyListModel.fromJson(jsonData);

        print("**** Product List Response ****");
        print("Product List Controller: $jsonData");

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
