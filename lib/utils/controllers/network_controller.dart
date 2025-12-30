import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  RxBool networkStatus = true.obs;

  Future<void> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      networkStatus.value = false;
    } else {
      networkStatus.value = true;
    }
    update();
  }
}
