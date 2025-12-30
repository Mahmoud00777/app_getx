// lib/app/customer/bindings/customer_binding.dart
import 'package:get/get.dart';
import '../controller/customers_controller.dart';

class CustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomersController>(() => CustomersController());
  }
}