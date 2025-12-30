// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import 'package:get/get.dart';
import 'package:pos_app/app/auth/view/login_screen.dart';
import 'package:pos_app/components/common_dialog.dart';
import 'package:pos_app/utils/constants.dart';

import 'package:shared_preferences/shared_preferences.dart';
// import 'package:unifyrh/app/attendance/areas_attendance.dart';
// import 'package:unifyrh/app/auth/view/login_screen.dart';
// import 'package:unifyrh/app/payroll/payroll.dart';
// import 'package:unifyrh/components/common_dialog.dart';
// import 'package:unifyrh/utils/app_size_config.dart';
// import 'package:unifyrh/utils/constants.dart';

// import '../app/attendance/attendance.dart';
// import '../app/attendance/mark_attendance.dart';
// import '../app/dashboard/home/component/header_image.dart';
// import '../app/holiday/holiday.dart';
// import '../app/leave/leave.dart';
// import '../app/notification/controller/notification_subscribe.dart';
// import '../app/todo/todo_screen.dart';
import '../utils/controllers/data_controller.dart';
import 'common_text.dart';
import 'custom_toast.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final DataController dataController = Get.put(DataController());
  // final SubscribeController subscribeController = Get.put(
  //   SubscribeController(),
  // );
  List<dynamic> allowedRanges = [];

  Future<void> loadGetxData() async {
    await dataController.loadMyData();
    await dataController.getAttendanceAreas();
    // await _requestLocationPermission();
    setState(() {
      allowedRanges = dataController.myAttendanceAreas.toList();
    });
  }

  @override
  void initState() {
    super.initState();
    loadGetxData();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryAppColor, secondaryAppColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
            ),
            // color: grey.withOpacity(0.4),
            padding: EdgeInsets.only(top: 50, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // HeaderImage(
                //   image: dataController.mySavedImage.value,
                //   errorText: dataController.mySavedFullName.value[0]
                //       .toCapitalized(),
                // ),
                // Container(
                //   height: 60,
                //   width: 60,
                //   decoration: BoxDecoration(
                //     color: white.withOpacity(0.5),
                //     shape: BoxShape.circle,
                //   ),
                //   child: Center(
                //     child: CommonText(
                //         text: dataController.mySavedFullName.value[0]
                //             .toCapitalized(),
                //         weight: FontWeight.w600,
                //         color: white,
                //         fontSize: 28),
                //   ),
                // ),
                SizedBox(height: 10),
                CommonText(
                  text: dataController.mySavedFullName.value,
                  weight: FontWeight.w500,
                  color: white,
                  fontSize: 18,
                ),
                CommonText(
                  text: dataController.mySavedUsername.value,
                  weight: FontWeight.w200,
                  color: textAppbar,
                  fontSize: 14,
                ),
              ],
            ),
          ),
          // SizedBox(height: 5),
          // listviewButton(
          //     icon: Icons.money_outlined,
          //     onPress: () {
          //       Navigator.pop(context);
          //       Get.to(() => ExpenseScreen());
          //     },
          //     text: "expense".tr),
          SizedBox(height: 5),
          // listviewButton(
          //   icon: Icons.calendar_month,
          //   onPress: () {
          //     Navigator.pop(context);
          //     Get.to(() => AttendanceScreen());
          //   },
          //   text: "attendance".tr,
          // ),
          // SizedBox(height: 5),
          // listviewButton(
          //   icon: Icons.today_rounded,
          //   onPress: () {
          //     Navigator.pop(context);
          //     Get.to(() => MarkAttendanceScreen());
          //   },
          //   text: "markattendance".tr,
          // ),
          // SizedBox(height: 5),
          // listviewButton(
          //   icon: Icons.share_location_rounded,
          //   onPress: () {
          //     Navigator.pop(context);
          //     Get.to(() => AreasAttendance(allowedRanges: allowedRanges));
          //   },
          //   text: "attedanceAreas".tr,
          // ),
          // SizedBox(height: 5),
          // listviewButton(
          //   icon: Icons.bed_outlined,
          //   onPress: () {
          //     Navigator.pop(context);
          //     Get.to(() => LeaveScreen());
          //   },
          //   text: "leave".tr,
          // ),
          // SizedBox(height: 5),
          // listviewButton(
          //   icon: Icons.payment_outlined,
          //   onPress: () {
          //     Navigator.pop(context);
          //     Get.to(() => PayrollScreen());
          //   },
          //   text: "payroll".tr,
          // ),
          // SizedBox(height: 5),
          // listviewButton(
          //   icon: Icons.holiday_village_outlined,
          //   onPress: () {
          //     Navigator.pop(context);
          //     Get.to(() => HolidayScreen());
          //   },
          //   text: "holiday".tr,
          // ),
          // SizedBox(height: 5),
          // listviewButton(
          //   icon: Icons.fact_check_outlined,
          //   onPress: () {
          //     Navigator.pop(context);
          //     Get.to(() => TodoScreen());
          //   },
          //   text: "todo".tr,
          // ),
          // Visibility(
          //   visible: dataController.mySavedURL.value == "23.94.61.169",
          //   child: Column(
          //     children: [
          //       SizedBox(height: 5),
          //       listviewButton(
          //           icon: Icons.assignment_turned_in_outlined,
          //           onPress: () {
          //             Navigator.pop(context);
          //             Get.to(() => ContractScreen());
          //           },
          //           text: "employeeContract".tr),
          //     ],
          //   ),
          // ),
          // SizedBox(height: 5),
          // listviewButton(
          //     icon: Icons.list_alt_outlined,
          //     onPress: () {
          //       Navigator.pop(context);
          //       Get.to(() => OrderScreen());
          //     },
          //     text: "orders".tr),
          // SizedBox(height: 5),
          // listviewButton(
          //     icon: Icons.currency_exchange_outlined,
          //     onPress: () {
          //       Navigator.pop(context);
          //       Get.to(() => TransactionScreen());
          //     },
          //     text: "transaction".tr),
          // SizedBox(height: 5),
          // listviewButton(
          //     icon: Icons.transcribe_outlined,
          //     onPress: () {
          //       Navigator.pop(context);
          //       Get.to(() => VisitScreen());
          //     },
          //     text: "visit".tr),
          // SizedBox(height: 5),
          // listviewButton(
          //     icon: Icons.payments_outlined,
          //     onPress: () {
          //       Navigator.pop(context);
          //       Get.to(() => PaymentScreen());
          //     },
          //     text: "payment".tr),
          Divider(color: Colors.black12),
          listviewButton(
            icon: Icons.logout_outlined,
            text: "logOut".tr,
            onPress: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              ModalHelper.showCustomModalBottomSheet(
                context,
                "logOut".tr,
                "sureToLogOut".tr,
                () async {
                  Navigator.pop(context, false);
                  CustomToast.showToast(
                    msg: "loggedOut".tr,
                    backgroundColor: Colors.green.withOpacity(0.6),
                  );
                  await prefs.setBool('loggedInStatus', false);
                  await dataController.loadMyData();
                  // await subscribeController.getSubsribe(
                  //   dataController.mySavedSID.value,
                  //   dataController.mySavedBaseURL.value,
                  //   dataController.mySavedEmail.value,
                  //   dataController.myDeviceToken.value,
                  //   true,
                  // );
                  Get.offAll(() => LoginScreen());
                },
                () {
                  Navigator.pop(context, false);
                },
              );
              //
              // await CommonDialog.show(
              //     context, 'Exit', 'Are you sure you want to logout?',
              //     () async {
              //   Navigator.pop(context, false);
              //   CustomToast.showToast(
              //       msg: "Logged Out",
              //       backgroundColor: Colors.green.withOpacity(0.6));
              //   await prefs.setBool('loggedInStatus', false);
              //   Get.offAll(() => LoginScreen());
              // }, () {
              //   Navigator.pop(context, false);
              // });
            },
          ),
          SizedBox(height: 150),
        ],
      ),
    );
  }

  //
  //--------------- Custom Functions
  //
  // Check if the user is under range
  Future<void> _checkLocation() async {
    await dataController.loadMyData();

    for (var area in allowedRanges) {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        double.parse(area['latitude'].toString()),
        double.parse(area['longitude'].toString()),
      );
      String firstName = placemarks.first.name != ""
          ? "${placemarks.first.name}, "
          : "";
      String thoroughFare = placemarks.first.thoroughfare != ""
          ? "${placemarks.first.thoroughfare}, "
          : "";
      String subLocality = placemarks.first.subLocality != ""
          ? "${placemarks.first.subLocality}, "
          : "";
      String locality = placemarks.first.locality != ""
          ? "${placemarks.first.locality}, "
          : "";
      area["address"] =
          "$firstName$thoroughFare$subLocality$locality${placemarks.first.country}";
    }
  }

  //
  //--------------- Check user location permission
  //
  // Future<void> _requestLocationPermission() async {
  //   LocationPermission permission = await Geolocator.checkPermission();

  //   if (permission == LocationPermission.denied ||
  //       await Permission.location.isDenied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       showNoPermissionDialog();
  //       return;
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     showNoPermissionDialog();
  //     return;
  //   }

  //   if (permission == LocationPermission.whileInUse ||
  //       permission == LocationPermission.always) {
  //     _checkLocation();
  //   }
  // }
}

//
//
class listviewButton extends StatelessWidget {
  final String text;
  final IconData icon;

  final Function() onPress;

  const listviewButton({
    super.key,
    required this.text,
    required this.onPress,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: grey.withOpacity(0.2),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 40,
      child: IconButton(
        color: textSubWhite,
        onPressed: onPress,
        style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        icon: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(icon, color: primaryAppColor),
              SizedBox(width: 5),
              CommonText(text: text),
            ],
          ),
        ),
      ),
    );
  }
}

class listviewContainer extends StatelessWidget {
  String? text;
  listviewContainer({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Text("$text"),
    );
  }
}
