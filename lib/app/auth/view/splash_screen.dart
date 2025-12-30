// ignore_for_file: unnecessary_statements

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:pos_app/app/dashboard/view/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:unifyrh/app/dashboard/dashboard.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../components/common_bottom_dialog_animation.dart';
import '../../../components/gradient_snackbar.dart';
import '../../../utils/constants.dart';
import '../../../utils/controllers/data_controller.dart';
import 'login_screen.dart';

/// App Colors
const Color primaryAppColor = Color(0xFF004F53);
const Color secondaryAppColor = Color(0xFF007C84);

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final DataController dataController = Get.put(DataController());
  bool? loggedInStatus;
  final LocalAuthentication auth = LocalAuthentication();

  Future<void> _getEnrollBiometrics() async {
    print("SplashScreen: _getEnrollBiometrics started");
    try {
      final List<BiometricType> availableBiometrics = await auth
          .getAvailableBiometrics();
      print(
        "SplashScreen: Available biometrics: ${availableBiometrics.length}",
      );

      if (availableBiometrics.isEmpty &&
          (dataController.enableBiometric.value == true)) {
        ModalHelperDialog.showCustomModalBottomSheetAnimation(
          context,
          'assets/animations/biometrics.json',
          'Go to system settings and configure Biometric first',
          () async {
            Navigator.pop(context, false);
            navigator();
          },
        );
      } else if (availableBiometrics.isNotEmpty &&
          dataController.enableBiometric.value == true &&
          dataController.loggedInStatus.value == true) {
        _biometricAuth();
      } else {
        navigator();
      }
    } catch (e) {
      navigator();
    }
  }

  Future<void> _biometricAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final bool isAuthenticated = await auth.authenticate(
        authMessages: <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: 'Biometric authentication required!',
          ),
        ],
        options: const AuthenticationOptions(),
        localizedReason: 'Please authenticate to use Employee HUB app',
      );

      if (isAuthenticated) {
        navigator();
      } else {
        Get.showSnackbar(
          gradientSnackbar(
            "Session Expired",
            "Please use credentials to login again",
            grey,
            Icons.warning_rounded,
          ),
        );
        await prefs.setBool('loggedInStatus', false);
        Future.delayed(const Duration(seconds: 1), () {
          Get.offAll(() => LoginScreen());
        });
      }
    } catch (e) {
      print("Biometric Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      await loadGetxData();
      await checkLoggedInStatus();
      await _checkBiometrics();
      await _getEnrollBiometrics();
    } catch (e) {
      navigator();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: SafeArea(
        child: PopScope(
          canPop: false,
          onPopInvoked: (didPop) {}, // ✅ شلنا async
          child: Scaffold(
            body: Center(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [primaryAppColor, secondaryAppColor],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),

                    /// Logo Animation
                    ClipRRect(
                      child:
                          Image(
                                height: 180,
                                width: 180,
                                image: AssetImage("assets/Azzakah.png"),
                                fit: BoxFit.contain,
                              )
                              .animate()
                              .fadeIn(
                                delay: 100.ms,
                                duration: 500.ms,
                                curve: Curves.easeOut,
                              )
                              .scale(
                                begin: const Offset(0.8, 0.8),
                                end: const Offset(1.0, 1.0),
                                duration: 450.ms,
                                curve: Curves.easeOutBack,
                              ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                    ).animate().fadeIn(delay: 200.ms, duration: 500.ms),

                    const Spacer(),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> checkLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loggedInStatus = prefs.getBool('loggedInStatus') ?? false;
    });
  }

  Future<void> loadGetxData() async {
    await dataController.loadMyData();
    var locale = Locale(
      dataController.langCode.value,
      dataController.langCountry.value,
    );
    Get.updateLocale(locale);
  }

  Future<void> _checkBiometrics() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      prefs.setBool('checkBiometric', canCheckBiometrics);
    } catch (_) {
      prefs.setBool('checkBiometric', false);
    }
  }

  void navigator() {
    Timer(const Duration(seconds: 2), () {
      if (loggedInStatus == true) {
        Get.offAll(() => DashboardScreen());
      } else {
        Get.offAll(() => LoginScreen());
      }
    });
  }
}

void _launchURL(String url) async {
  try {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  } catch (e) {
    print('Error launching URL: $e');
  }
}
