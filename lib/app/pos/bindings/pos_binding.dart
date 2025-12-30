import 'package:get/get.dart';
import '../controller/pos_controller.dart';

class PosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PosController>(() => PosController());
  }
}