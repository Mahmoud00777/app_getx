import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/auth/view/login_screen.dart';
// import '../app/notification/controller/notification_subscribe.dart';
import '../components/custom_toast.dart';
import '../components/gradient_snackbar.dart';
import 'controllers/data_controller.dart';

Color primaryAppColor = Color(0xFF004F53); // 56ca68
Color secondaryAppColor = Color(0xFF007C84); //  379047
Color primaryBlueApp08Opacity = Color.fromRGBO(21, 93, 160, 1).withOpacity(0.8);
Color white = Colors.white;
Color black = Colors.black;
Color red = Colors.red;
Color blue = Colors.blue;
Color green = Colors.green;
Color grey = Colors.grey;
Color orange = Colors.orange;
Color transparent = Colors.transparent;
Color textAppbar = Colors.white70;
Color textSubWhite = Colors.white38;
Color scaffoldBackground = Colors.grey.shade100;
Color checkOutRed = Color.fromARGB(255, 182, 61, 52);
Color checkInGreen = Color.fromARGB(255, 77, 164, 80);
Color primaryAppColorSd1 = Color(0xFF007C84);
Color primaryAppColorSd2 = Color.fromARGB(255, 1, 95, 102);
Color primaryAppColorSd3 = Color.fromARGB(255, 2, 67, 72);
Color greyShade200 = Colors.grey.shade200;
Color greyShade300 = Colors.grey.shade300;
Color greyShade600 = Colors.grey.shade600;
Color draftColor = Color.fromARGB(255, 190, 149, 55);
Color statusGreen = Color.fromARGB(255, 56, 178, 144);
Color statusYellow = Color.fromARGB(255, 198, 185, 86);
Color statusRed = Color.fromARGB(255, 178, 56, 76);
Color statusOrange = Color.fromARGB(255, 205, 128, 57);
Color expandibleWidgetColor = Color.fromARGB(255, 201, 221, 204);

//------ Converts Color to MaterialColor
MaterialColor getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;

  final Map<int, Color> shades = {
    50: Color.fromRGBO(red, green, blue, .1),
    100: Color.fromRGBO(red, green, blue, .2),
    200: Color.fromRGBO(red, green, blue, .3),
    300: Color.fromRGBO(red, green, blue, .4),
    400: Color.fromRGBO(red, green, blue, .5),
    500: Color.fromRGBO(red, green, blue, .6),
    600: Color.fromRGBO(red, green, blue, .7),
    700: Color.fromRGBO(red, green, blue, .8),
    800: Color.fromRGBO(red, green, blue, .9),
    900: Color.fromRGBO(red, green, blue, 1),
  };

  return MaterialColor(color.value, shades);
}

// Displays msg when User session is expired
Future<void> sessionExp(String message, bool session) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final DataController dataController = Get.put(DataController());
  // final SubscribeController subscribeController = Get.put(
  //   SubscribeController(),
  // );

  if (message.contains("Invalid User") ||
      message.contains("Session Not Found") ||
      session == false) {
    Get.showSnackbar(
      gradientSnackbar(
        "sessionExp".tr,
        "loginAgain".tr,
        red,
        Icons.warning_rounded,
      ),
    );
    Get.offAll(() => LoginScreen());
    await prefs.setBool('loggedInStatus', false);
    await dataController.loadMyData();
    // await subscribeController.getSubsribe(
    //   dataController.mySavedSID.value,
    //   dataController.mySavedBaseURL.value,
    //   dataController.mySavedEmail.value,
    //   dataController.myDeviceToken.value,
    //   true,
    // );
    CustomToast.showToast(
      msg: "loggedOut".tr,
      backgroundColor: Colors.green.withOpacity(0.6),
    );
  }
}

// Displays msg when User session is expired
Future<void> sessionExpLite() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final DataController dataController = Get.put(DataController());
  // final SubscribeController subscribeController = Get.put(
  //   SubscribeController(),
  // );

  Get.showSnackbar(
    gradientSnackbar(
      "sessionExp".tr,
      "loginAgain".tr,
      red,
      Icons.warning_rounded,
    ),
  );
  Get.offAll(() => LoginScreen());
  await prefs.setBool('loggedInStatus', false);
  await dataController.loadMyData();
  // await subscribeController.getSubsribe(
  //   dataController.mySavedSID.value,
  //   dataController.mySavedBaseURL.value,
  //   dataController.mySavedEmail.value,
  //   dataController.myDeviceToken.value,
  //   true,
  // );
  CustomToast.showToast(
    msg: "loggedOut".tr,
    backgroundColor: Colors.green.withOpacity(0.6),
  );
}

//  Format time 2024-01-01 09:00:00 to 09:00 AM
String formatActivityTime(String dateTimeString) {
  // Parse the input date-time string
  DateTime dateTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTimeString);

  // Format it to the desired 12-hour format with minutes and AM/PM
  String formattedTime = DateFormat('hh:mm a').format(dateTime);

  return formattedTime;
}

//  Format time 2024-01-01 09:00:00 to 01-01-2024
String formatRecentDate(String dateTimeString) {
  DateTime dateTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTimeString);
  String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
  return formattedDate;
}

//  Format time 2024-01-01 09:00:00 to 09:00:00
String formatRecentTime(String dateTimeString, bool? is12h) {
  DateTime dateTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTimeString);
  bool? AmPm = is12h ?? false;
  if (AmPm == true) {
    String formattedTime = DateFormat('h:mm a').format(dateTime);
    return formattedTime;
  } else {
    String formattedTime = DateFormat('HH:mm:ss').format(dateTime);
    return formattedTime;
  }
  // String formattedTime = DateFormat('HH:mm:ss').format(dateTime);
}

// Language List
final List<Map<String, dynamic>> langList = [
  {
    'language': "English",
    'name': "English",
    'country': "US",
    'code': "en",
    'image': "assets/flags/us_flag.png",
  },
  {
    'language': "French",
    'name': "Français",
    'country': "FR",
    'code': "fr",
    'image': "assets/flags/fr_flag.png",
  },
  {
    'language': "Spanish",
    'name': "Español",
    'country': "SP",
    'code': "es",
    'image': "assets/flags/sp_flag.png",
  },
  {
    'language': "German",
    'name': "Deutsch",
    'country': "GR",
    'code': "du",
    'image': "assets/flags/gr_flag.png",
  },
  {
    'language': "Turkish",
    'name': "Türkçe",
    'country': "TR",
    'code': "tr",
    'image': "assets/flags/tr_flag.png",
  },
  {
    'language': "Swedish",
    'name': "Svenska",
    'country': "SE",
    'code': "sv",
    'image': "assets/flags/se_flag.png",
  },
  {
    'language': "Finnish",
    'name': "Suomi",
    'country': "FI",
    'code': "fi",
    'image': "assets/flags/fi_flag.png",
  },
  {
    'language': "Latin",
    'name': "Latina",
    'country': "VA",
    'code': "la",
    'image': "assets/flags/la_flag.png",
  },
  {
    "language": "Romanian",
    "name": "Română",
    "country": "RO",
    "code": "ro",
    "image": "assets/flags/ro_flag.png",
  },
  {
    'language': "Thai",
    'name': "ไทย",
    'country': "TH",
    'code': "th",
    'image': "assets/flags/th_flag.png",
  },
  {
    'language': "Chinese",
    'name': "官话",
    'country': "CN",
    'code': "cn",
    'image': "assets/flags/cn_flag.png",
  },
  {
    'language': "Arabic",
    'name': "العربية",
    'country': "SA",
    'code': "ar",
    'image': "assets/flags/ar_flag.png",
  },
  {
    'language': "Urdu",
    'name': "اُردُو",
    'country': "PK",
    'code': "ur",
    'image': "assets/flags/pk_flag.png",
  },
];
