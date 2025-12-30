import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:pos_app/components/common_text.dart';
import 'package:pos_app/utils/constants.dart';

import '../utils/controllers/network_controller.dart';
import 'no_internet_dialog.dart';

// ignore: must_be_immutable
class CustomAppbarHomeClass extends StatefulWidget {
  String title;
  Widget actionWidget;
  CustomAppbarHomeClass({
    required this.title,
    required this.actionWidget,
    super.key,
  });

  @override
  State<CustomAppbarHomeClass> createState() => _CustomAppbarHomeClassState();
}

class _CustomAppbarHomeClassState extends State<CustomAppbarHomeClass> {
  final NetworkController networkController = Get.put(NetworkController());
  Timer? _timer;

  Future<void> checkNetwork() async {
    await networkController.checkConnectivity();
  }

  @override
  void initState() {
    super.initState();
    checkConnectivity(context);
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      checkNetwork();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(color: primaryAppColor),
        ),
        actions: [
          networkController.networkStatus.value
              ? widget.actionWidget
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Image(
                    height: 26,
                    image: AssetImage("assets/icons/no_wifi2.png"),
                  ),
                ),
        ],
        centerTitle: true,
        title:
            CommonText(
                  text: widget.title,
                  color: white.withOpacity(0.8),
                  fontSize: 18,
                )
                .animate()
                .fadeIn(delay: 200.ms, duration: 200.ms)
                .slideY(duration: 200.ms),
        backgroundColor: transparent,
      );
    });
  }
}
