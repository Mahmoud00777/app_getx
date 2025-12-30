import "dart:io";
import "package:flutter/services.dart";
import "package:get/get.dart";

import "package:intl/intl.dart";
import "package:ntp/ntp.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:pos_app/utils/controllers/network_controller.dart";

// import "../../app/attendance/component/auto_date_time_dialog_ios.dart";

class TimeController extends GetxController {
  final NetworkController networkController = Get.put(NetworkController());
  RxString networkTime = '00:00'.obs;
  RxString currentBootTime = '0'.obs;
  RxString prevBootTime = '00'.obs;
  RxBool isValid = true.obs;

  Future<void> loadTimeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    networkTime.value = prefs.getString('networkTime') ?? "00:01";

    update();
  }

  Future<void> fetchBootTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    TimeSinceBoot timeSinceBoot = TimeSinceBoot();
    String? bootTime = await timeSinceBoot.getTimeSinceBoot();
    double value = double.parse(bootTime);
    int formattedBootTime = value.toInt();
    prevBootTime.value =
        prefs.getString('currentBootTime') ?? formattedBootTime.toString();
    await prefs.setString("currentBootTime", formattedBootTime.toString());
    currentBootTime.value =
        prefs.getString('currentBootTime') ?? formattedBootTime.toString();

    update();
  }

  //// Fetching network time for iOS time validation in Employee HUB
  Future<void> fetchNetworkTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final NetworkController networkController = Get.put(NetworkController());
    await networkController.checkConnectivity();
    try {
      if (networkController.networkStatus.value == true) {
        DateTime ntpTime = await NTP.now();
        String formattedNTP = DateFormat('HH:mm').format(ntpTime);
        print("Network Time NTP: $formattedNTP");
        await prefs.setString('networkTime', formattedNTP);
      }
    } catch (e) {
      print("fetchNetworkTime Catch Error: $e");
    }
  }

  Future<void> checkiOSAutoTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    networkController.checkConnectivity();
    if (Platform.isIOS) {
      await fetchNetworkTime();
      await loadTimeData();
      await fetchBootTime();

      int currentBoot = int.parse(currentBootTime.value);
      int preBoot = int.parse(prevBootTime.value);
      int bootTime0 = currentBoot - preBoot;
      String bootTime = calBootTime(bootTime0);

      DateTime now = DateTime.now();
      String deviceTime = DateFormat('HH:mm').format(now);
      String validTime;
      if (networkController.networkStatus.value == false) {
        validTime = await addTimes(bootTime, networkTime.value);
      } else {
        validTime = await addTimes("00:00", networkTime.value);
      }
      await prefs.setString('networkTime', validTime);
      timeDifference(deviceTime, validTime);
      update();
    }
  }

  Future<void> timeDifference(String time1, String time2) async {
    // Parse the time strings into DateTime objects
    DateFormat format = DateFormat("HH:mm");
    DateTime t1 = format.parse(time1);
    DateTime t2 = format.parse(time2);

    // Calculate the difference in minutes
    int differenceInMinutes = t1.difference(t2).inMinutes.abs();
    print("Time Difference: $differenceInMinutes");
    if (differenceInMinutes > 8) {
      // showNoDateTimeDialogiOS();
      isValid.value = false;
    }
    update();
    // return differenceInMinutes > 5;
  }

  //
  //// Fetching network time for iOS time validation in CLOCK PUNCH
  // Future<void> fetchNetworkTime() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   try {
  //     var response = await http.get(Uri.parse(
  //         'https://timeapi.io/api/time/current/zone?timeZone=Asia/Baghdad'));
  //     var jsonData = json.decode(response.body) as Map<String, dynamic>;
  //     DateTime _ntpTime = await NTP.now();
  //     String formattedNTP = DateFormat('HH:mm').format(_ntpTime);
  //     print("Network Time API: ${jsonData["time"]}");
  //     print("Network Time NTP: $formattedNTP");
  //     if (response.statusCode == 200) {
  //       await prefs.setString('networkTime', "${jsonData["time"]}");
  //     }
  //   } catch (e) {
  //     print("Catch error: $e");
  //   }
  // }
}

class TimeSinceBoot {
  static const platform = MethodChannel('com.example/bootTime');

  Future<String> getTimeSinceBoot() async {
    try {
      final String time = await platform.invokeMethod('getBootTime');
      return time;
    } on PlatformException catch (e) {
      return "Failed to get boot time: '${e.message}'.";
    }
  }
}

String calBootTime(int seconds) {
  int totalSecondsInADay = 24 * 60 * 60;
  int secondsInCycle = seconds % totalSecondsInADay;

  int hours = secondsInCycle ~/ 3600;
  int minutes = (secondsInCycle % 3600) ~/ 60;

  String formattedTime =
      "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}";

  return formattedTime;
}

Future<String> addTimes(String time1, String time2) async {
  // Split the time strings into hours and minutes
  List<String> parts1 = time1.split(':');
  List<String> parts2 = time2.split(':');

  // Convert to integers
  int hours1 = int.parse(parts1[0]);
  int minutes1 = int.parse(parts1[1]);
  int hours2 = int.parse(parts2[0]);
  int minutes2 = int.parse(parts2[1]);

  // Add hours and minutes
  int totalMinutes = minutes1 + minutes2;
  int extraHours = totalMinutes ~/ 60; // Convert excess minutes to hours
  totalMinutes %= 60; // Remaining minutes after hour conversion

  int totalHours = hours1 + hours2 + extraHours;
  totalHours %= 24; // Wrap around for 24-hour format

  // Format the result as HH:mm
  String result =
      '${totalHours.toString().padLeft(2, '0')}:${totalMinutes.toString().padLeft(2, '0')}';

  return result;
}
