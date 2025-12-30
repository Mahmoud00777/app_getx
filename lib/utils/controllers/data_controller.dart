import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../../app/attendance/component/loading_dialog.dart';
// import '../../app/attendance/controller/location_controller.dart';
import '../constants.dart';

class DataController extends GetxController {
  RxString myCurrentYear = '2000'.obs;
  RxString myCurrentDate = ''.obs;
  RxString myCurrentTime = '00:00 AM'.obs;
  RxString mysavedProtocol = ''.obs;
  RxString mySavedURL = ''.obs;
  RxString mySavedBaseURL = ''.obs;
  RxString mySavedUsername = ''.obs;
  RxString mySavedPassword = ''.obs;
  RxString mySavedName = "- - -".obs;
  RxString mySavedFullName = ''.obs;
  RxString mySavedEMP = "HR-EMP-00001".obs;
  RxString mySavedEmail = "- - -".obs;
  RxString mySavedSID = '- - -'.obs;
  RxString myDeviceToken = '- - -'.obs;
  RxString mySavedImage = ''.obs;
  RxString version = "0".obs;

  RxString myCurrentAddress = '- - -'.obs;
  RxString myCurrentLatitude = ''.obs;
  RxString myCurrentLongitude = ''.obs;
  RxString myCurrentOrdinalDate = "- - -".obs;
  RxString myAttCurrentDate = ''.obs;

  RxString myCheckIn = '123'.obs;
  RxString myCheckOut = '321'.obs;
  RxString myAttendanceDate = '456'.obs;
  RxString myAttendanceTime = "123".obs;
  RxString myFormDate = "123".obs;
  RxBool checkBiometric = false.obs;
  RxBool enableBiometric = false.obs;
  RxBool syncLang = true.obs;
  RxBool loggedInStatus = false.obs;
  RxString langCode = "en".obs;
  RxString langCountry = "US".obs;
  RxString myDuration = "".obs;
  RxString myHomepageDate = '- - -'.obs;
  RxString myFormattedTime = ''.obs;
  RxString myFormattedDate = ''.obs;
  RxList myDraftAttendance = [].obs;
  RxList myAttendanceAreas = [].obs;
  RxList myServerList = [].obs;
  RxBool myMockLocation = false.obs;

  // Recent
  RxString recentcurrentDate = "".obs;
  RxString recentCheckinDateTime = "".obs;
  RxString recentCheckinType = "".obs;
  RxString recentAttRecord = "".obs;
  RxMap recentFilterRecord = {}.obs;
  RxString recentCheckinDate = "".obs;
  RxString recentCheckoutDate = "".obs;
  RxString recentCheckinTime = "".obs;
  RxString recentCheckoutTime = "".obs;
  RxString recentStatusDate = "".obs;
  RxBool isUserCheckin = false.obs;
  RxBool serverCheckIn = false.obs;
  RxString attPicType = "Front & Back".obs;

  //////////////////////////////////////////////////////Get Stored Data
  Future<void> loadMyData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String portocol = prefs.getString('savedProtocol') ?? "---";
    String url = prefs.getString('savedURL') ?? "---";
    String baseUrl = prefs.getString('baseUrl') ?? "---";
    String username = prefs.getString('username') ?? "---";
    String password = prefs.getString('savedPassword') ?? "---";
    String name = prefs.getString('name') ?? "---";
    String emp = prefs.getString('emp') ?? "HR-EMP-00002";
    String email = prefs.getString('email') ?? "---";
    String sid = prefs.getString('SID') ?? "---";
    String fullName = prefs.getString('fullName') ?? "---";
    String deviceToken = prefs.getString('savedDeviceToken') ?? "---";
    String userImage = prefs.getString('userImage') ?? "";
    String checkInDate = prefs.getString('checkInDate') ?? "123";
    String checkOutDate = prefs.getString('checkOutDate') ?? "312";
    version.value = prefs.getString('version') ?? "0";

    bool checkBiometric = prefs.getBool('checkBiometric') ?? false;
    bool enableBiometric = prefs.getBool('enableBiometric') ?? false;
    bool loggedInStatus = prefs.getBool('loggedInStatus') ?? false;
    String langCode = prefs.getString('langCode') ?? "en";
    String langCountry = prefs.getString('langCountry') ?? "US";

    String recentCheckinDateTime =
        prefs.getString('recentCheckinDateTime') ?? "2024-01-01 09:00:00";
    String recentCheckinType = prefs.getString('recentCheckinType') ?? "";
    bool server = prefs.getBool('serverCheckIn') ?? false;
    attPicType.value = prefs.getString('attPicType') ?? "Front & Back";

    mysavedProtocol.value = portocol;
    mySavedURL.value = url;
    mySavedBaseURL.value = baseUrl;
    mySavedUsername.value = username;
    mySavedPassword.value = password;
    mySavedName.value = name;
    mySavedEMP.value = emp;
    mySavedEmail.value = email;
    mySavedSID.value = sid;
    mySavedFullName.value = fullName;
    myCheckIn.value = checkInDate;
    myCheckOut.value = checkOutDate;
    // checkBiometric.value = checkBiometric;
    // enableBiometric.value = enableBiometric;
    // loggedInStatus.value = loggedInStatus;
    // langCode.value = langCode;
    // langCountry.value = langCountry;
    myDeviceToken.value = deviceToken;
    mySavedImage.value = userImage;
    syncLang.value = prefs.getBool('syncLang') ?? true;

    // recentCheckinDateTime.value = recentCheckinDateTime;
    // recentCheckinType.value = recentCheckinType;
    serverCheckIn.value = server;

    update();
  }

  ///////////////////////////////////////////////////Get Servers List
  Future<void> getServers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> listString = prefs.getStringList('serverList') ?? [];

    myServerList.value = listString
        .map<Map<String, dynamic>>((data) => json.decode(data))
        .toList();

    update();
  }

  ///////////////////////////////////////////////////Get Attendance Areas List
  Future<void> getAttendanceAreas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> areaListString = prefs.getStringList('attendanceAreas') ?? [];

    myAttendanceAreas.value = areaListString
        .map<Map<String, dynamic>>((areaString) => json.decode(areaString))
        .toList();

    update();
  }

  ///////////////////////////////////////////////////Get Draft Attendance List
  Future<void> getDraftAttendance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> dataListString = prefs.getStringList('dataList') ?? [];

    myDraftAttendance.value = dataListString
        .map<Map<String, dynamic>>((dataString) => json.decode(dataString))
        .toList();

    update();
  }

  ////////////////////////////////////////////////////Get Current Date (01-15-2024)
  Future<void> getCurrentDate() async {
    DateTime now = DateTime.now();
    String formattedYear = "${now.year}";
    String formattedDate = DateFormat('EEE dd MMM yyyy').format(now);
    String formattedDate2 = DateFormat('yyyy-MM-dd').format(now);
    String formattedDate3 = DateFormat('dd-MM-yyyy').format(now);
    String formattedAttDate =
        "${now.year}-${_twoDigits(now.month)}-${_twoDigits(now.day)}";

    myAttCurrentDate.value = formattedAttDate;
    myCurrentDate.value = formattedDate;
    myCurrentYear.value = formattedYear;
    myAttendanceDate.value = formattedDate2;
    myFormDate.value = formattedDate3;
    recentcurrentDate.value = formattedDate3;
    update();
  }

  ////////////////////////////////////////////////////Get current time (04:33 PM)
  Future<void> getCurrentTime() async {
    DateTime now = DateTime.now();
    int hour = now.hour;
    int minute = now.minute;
    int sec = now.second;

    String period = (hour < 12) ? 'AM' : 'PM';
    hour = (hour > 12) ? hour - 12 : hour;
    String formattedTime = "$hour:${_twoDigits(minute)} $period";
    String formattedTime2 =
        "${_twoDigits(now.hour)}:${_twoDigits(minute)}:${_twoDigits(sec)}";

    String formattedHomepageDate = DateFormat('E, dd MMM yyyy').format(now);
    myHomepageDate.value = formattedHomepageDate;
    myCurrentTime.value = formattedTime;
    myAttendanceTime.value = formattedTime2;
    update();
  }

  Future<void> getCheckInTime() async {
    DateTime now = DateTime.now();
    var formatter = DateFormat('HH:mm:ss');
    String formattedTime24h = formatter.format(now);
    myFormattedTime.value = formattedTime24h;
    update();
  }

  Future<void> getCheckOutTime() async {
    DateTime now = DateTime.now();
    var formatter = DateFormat('HH:mm:ss');
    String formattedTime24h = formatter.format(now);
    myFormattedTime.value = formattedTime24h;
    update();
  }

  String _twoDigits(int n) {
    return n.toString().padLeft(2, '0');
  }

  ////////////////////////////////////////////////////////// Getting Duration
  Future<void> calculateDuration() async {
    String checkIn = "";
    String checkOut = "4:20 PM";
    Map recentRecord = recentFilterRecord;

    if (formatRecentDate(recentRecord["checkin"] ?? "2024-01-01 09:00:00") ==
        recentcurrentDate.value) {
      checkIn = formatRecentTime(
        recentRecord["checkin"] ?? "2024-01-01 09:00:00",
        true,
      );
    } else {
      checkIn = myCurrentTime.value;
    }

    if (formatRecentDate(recentRecord["checkout"] ?? "2024-01-01 09:00:00") ==
        recentcurrentDate.value) {
      checkOut = formatRecentTime(
        recentRecord["checkout"] ?? "2024-01-01 09:00:00",
        true,
      );
    } else {
      checkOut = myCurrentTime.value;
    }

    if (checkIn == checkOut) {
      myDuration.value = "--:--";
    } else {
      final DateFormat format = DateFormat('h:mm a');
      final DateTime checkInTime = format.parse(checkIn);
      final DateTime checkOutTime = format.parse(checkOut);
      final Duration duration = checkOutTime.difference(checkInTime);

      if (duration.isNegative) {
        myDuration.value = "--:--";
      } else {
        await formatDuration(duration);
      }
      update();
    }
  }

  Future<void> formatDuration(Duration duration) async {
    if (duration.inHours > 0) {
      String hoursLabel = duration.inHours == 1 ? 'hr' : 'hrs';
      myDuration.value =
          '${duration.inHours.toString().padLeft(2, '0')} $hoursLabel';
    } else {
      String minutesLabel = duration.inMinutes == 1 ? 'min' : 'mins';
      myDuration.value =
          '${duration.inMinutes.toString().padLeft(2, '0')} $minutesLabel';
    }
    update();
  }

  ////////////////////////////////////////////////////Get ordinal current date (3rd April 2024)
  String ordinalCurrentDate() {
    DateTime now = DateTime.now();
    String daySuffix(int day) {
      if (day >= 11 && day <= 13) {
        return 'th';
      }
      switch (day % 10) {
        case 1:
          return 'st';
        case 2:
          return 'nd';
        case 3:
          return 'rd';
        default:
          return 'th';
      }
    }

    String dayWithSuffix = DateFormat('d').format(now) + daySuffix(now.day);
    String monthYear = DateFormat('MMMM yyyy').format(now);
    myCurrentOrdinalDate.value = "$dayWithSuffix $monthYear";

    update();
    return '$dayWithSuffix $monthYear';
  }

  //////////////////////////////////////////////////////////Checking location permission
  Future<void> checkLocationPermission() async {
    PermissionStatus status = await Permission.location.status;

    if (status.isGranted) {
      await getCurrentLocation();
      print("Location Permission Granted");
    } else {
      PermissionStatus result = await Permission.location.request();
      print("Location Permission Requesting");
      if (result.isGranted) {
        await getCurrentLocation();
      } else {
        print('Location permission denied.');
        myCurrentAddress.value = "Location Permission Denied";
      }
    }
    update();
  }

  ////////////////////////////////////////////////////////Getting current location
  Future<void> getCurrentLocation() async {
    // final AddressController addressController = Get.put(AddressController());
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
      );
      myCurrentLatitude.value = position.latitude.toString();
      myCurrentLongitude.value = position.longitude.toString();

      bool mockLocation = position.isMocked;
      myMockLocation.value = mockLocation;

      // try {
      //   addressController.fetchAddress(
      //     myCurrentLatitude.value,
      //     myCurrentLongitude.value,
      //   );
      //   update();
      // } catch (e) {
      //   print('Catch Error: $e');
      // }
    } catch (e) {
      print('Catch Error: $e');
    }
    update();
  }

  //////////////////////////////////////////////////////// Getting current location w/ dialog
  Future<void> getCurrentLocationDialog() async {
    // final AddressController addressController = Get.put(AddressController());
    // showLoadingDialog();
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
      );
      myCurrentLatitude.value = position.latitude.toString();
      myCurrentLongitude.value = position.longitude.toString();

      try {
        bool mockLocation = position.isMocked;
        myMockLocation.value = mockLocation;

        // addressController.fetchAddress(
        //   myCurrentLatitude.value,
        //   myCurrentLongitude.value,
        // );
      } catch (e) {
        print('Catch Error: $e');
      }
      update();
    } catch (e) {
      print('Catch Error: $e');
    }
    Get.back();
    update();
  }

  //////////////////////////////////////////////////////// Recent Attendance Record
  Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? attListJson = prefs.getString('attList');

    if (attListJson == null || attListJson.isEmpty) {
      recentAttRecord.value = "[]";
      update();
      return;
    }

    List<dynamic> jsonData = jsonDecode(attListJson);
    recentAttRecord.value = jsonData.toString();
    update();
  }

  Future<void> getUserDataByName(String username) async {
    final prefs = await SharedPreferences.getInstance();
    final String? attListJson = prefs.getString('attList');

    if (attListJson != null && attListJson.isNotEmpty) {
      List<dynamic> jsonData = jsonDecode(attListJson);
      List<Map<String, dynamic>> attList = List<Map<String, dynamic>>.from(
        jsonData,
      );

      recentFilterRecord.value = attList.firstWhere(
        (item) => item['name'] == username,
        orElse: () => {},
      );
    } else {
      recentFilterRecord.value = {};
    }
    update();
  }

  ////////////////////////////////////////////////////////
  Future<void> checkRecentAttendance() async {
    await getUserData();
    await getUserDataByName(mySavedName.value);

    Map<dynamic, dynamic> recentRecord = recentFilterRecord;

    recentCheckinDate.value = formatRecentDate(
      recentRecord["checkin"] ?? "2024-01-01 09:00:00",
    );
    recentCheckoutDate.value = formatRecentDate(
      recentRecord["checkout"] ?? "2024-01-02 06:00:00",
    );
    recentCheckinTime.value = formatRecentTime(
      recentRecord["checkin"] ?? "2024-01-01 09:00:00",
      true,
    );
    recentCheckoutTime.value = formatRecentTime(
      recentRecord["checkout"] ?? "2024-01-01 06:00:00",
      true,
    );
    recentStatusDate.value = formatRecentDate(
      recentRecord["statusDate"] ?? "2024-01-01 06:00:00",
    );

    if (recentStatusDate.value == recentcurrentDate.value) {
      isUserCheckin.value = recentRecord["status"] ?? false;
    } else {
      isUserCheckin.value = false;
    }
  }
}
