// ignore_for_file: unrelated_type_equality_checks
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pos_app/app/auth/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:pos_app/route/app_pages.dart';
// import 'app/attendance/controller/attendance_areas_controller.dart';
// import 'app/attendance/controller/draft_attendance_controller.dart';
import 'utils/constants.dart' hide primaryAppColor;
import 'utils/controllers/data_controller.dart';
import 'utils/controllers/time_controller.dart';
import 'utils/language/messages.dart';
import 'package:background_fetch/background_fetch.dart';

@pragma('vm:entry-point')
// Background Task
void backgroundFetchHeadlessTask(HeadlessTask task) async {
  String taskId = task.taskId;
  bool isTimeout = task.timeout;
  if (isTimeout) {
    // This task has exceeded its allowed running-time.
    // You must stop what you're doing and immediately .finish(taskId)
    print("[BackgroundFetch] Headless task timed-out: $taskId");
    BackgroundFetch.finish(taskId);
    return;
  }
  print('[BackgroundFetch] Headless event received.');
  // Do your work here...
  //  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //       FlutterLocalNotificationsPlugin(); const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //      AndroidNotificationDetails(
  //     'your_channel_id',
  //     'Attendance Areas',
  //     channelDescription: 'Your channel description',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //     showWhen: false);
  //       const NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);
  //    await flutterLocalNotificationsPlugin.show(
  //      0,
  //     'Background Task',
  //     'Syncing ',
  //     platformChannelSpecifics,
  //     payload: 'Default_Sound');
  //
  final DataController dataController = Get.put(DataController());
  // final AttendanceAreasController attendanceAreasController = Get.put(
  //   AttendanceAreasController(),
  // );
  await dataController.loadMyData();
  // attendanceAreasController.fetchAreas(
  //   dataController.mySavedSID.value,
  //   dataController.mySavedBaseURL.value,
  // );
  // final DraftAttendanceController draftAttendanceController = Get.put(
  //   DraftAttendanceController(),
  // );
  final TimeController timeController = Get.put(TimeController());
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult.contains(ConnectivityResult.wifi) ||
      connectivityResult.contains(ConnectivityResult.mobile)) {
    // draftAttendanceController.syncing();
    timeController.fetchNetworkTime();
  }
  await BackgroundFetch.finish(taskId);
}

Future<void> main() async {
  print("=== APP STARTING ===");
  WidgetsFlutterBinding.ensureInitialized();
  print("=== Flutter binding initialized ===");

  // Initialize Firebase through FirebaseHelper to avoid duplicate initialization
  print("=== Initializing Firebase ===");
  // await FirebaseHelper.init();
  print("=== Firebase initialized ===");

  // await FirebaseHelper.requestNotificationPermissions();
  // await NotificationServices().initNotification();
  // await FirebaseHelper.getDeviceToken();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  //Background Functions
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);

  print("=== Starting MyApp ===");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  String selectedLanguage = 'en';
  final DataController dataController = Get.put(DataController());
  var materialColor = getMaterialColor(primaryAppColor);

  @override
  void initState() {
    super.initState();
    loadGetxData();
    initPlatformState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> initPlatformState() async {
    // Configure BackgroundFetch.
    int status = await BackgroundFetch.configure(
      BackgroundFetchConfig(
        minimumFetchInterval: 45,
        stopOnTerminate: false,
        enableHeadless: true,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresStorageNotLow: false,
        requiresDeviceIdle: false,
        requiredNetworkType: NetworkType.NONE,
      ),
      (String taskId) async {
        // <-- Event handler
        // This is the fetch-event callback.
        print("[BackgroundFetch] Event received $taskId");

        // IMPORTANT:  You must signal completion of your task or the OS can punish your app
        // for taking too long in the background.
        BackgroundFetch.finish(taskId);
      },
      (String taskId) async {
        // <-- Task timeout handler.
        // This task has exceeded its allowed running-time. You must stop what you're doing and immediately .finish(taskId)
        print("[BackgroundFetch] TASK TIMEOUT taskId: $taskId");
        BackgroundFetch.finish(taskId);
      },
    );
    print('[BackgroundFetch] configure success: $status');

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {}
  }

  @override
  Widget build(BuildContext context) {
    print("=== MyApp build() called ===");
    return Directionality(
      textDirection: _getTextDirection(),
      child: GetMaterialApp(
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        translations: Messages(),
        locale: Locale('en', 'US'),
        fallbackLocale: Locale('en', 'US'),
        title: 'ERPNext Employee HUB',
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.cupertino,
        transitionDuration: Duration(milliseconds: 600),
        theme: ThemeData(
          scaffoldBackgroundColor: scaffoldBackground,
          colorScheme: ColorScheme.fromSeed(seedColor: primaryAppColor),
          useMaterial3: true,
          primarySwatch: materialColor,
          appBarTheme: AppBarTheme(
            backgroundColor: primaryAppColor,
            iconTheme: IconThemeData(color: white.withOpacity(0.8)),
            foregroundColor: white,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: "Poppins",
        ),
        home: SplashScreen(),
      ),
    );
  }

  //
  //------ Custom Functions
  //

  Future<void> loadGetxData() async {
    await dataController.loadMyData();
    await dataController.getCurrentDate();
    await dataController.getCurrentTime();
    await setArgs();
  }

  Future<void> setArgs() async {
    setState(() {
      selectedLanguage = dataController.langCode.value;
    });
  }

  TextDirection _getTextDirection() {
    return (selectedLanguage == 'ar') || (selectedLanguage == 'ur')
        ? TextDirection.rtl
        : TextDirection.ltr;
  }
}
