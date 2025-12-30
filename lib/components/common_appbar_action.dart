import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:pos_app/components/common_text.dart';
import 'package:pos_app/utils/constants.dart';

import '../utils/controllers/network_controller.dart';
import 'no_internet_dialog.dart';

// ignore: must_be_immutable
class CustomAppbarActClass extends StatefulWidget {
  String title;
  Function()? onActPress;
  CustomAppbarActClass({
    required this.title,
    required this.onActPress,
    super.key,
  });

  @override
  State<CustomAppbarActClass> createState() => _CustomAppbarClassState();
}

class _CustomAppbarClassState extends State<CustomAppbarActClass> {
  final NetworkController networkController = Get.put(NetworkController());
  Timer? _timer;

  Future<void> checkNetwork() async {
    await networkController.checkConnectivity();
  }

  @override
  void initState() {
    super.initState();
    // checkConnectivityHomePage();
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
      return customAppbarAct(
        widget.title,
        networkController.networkStatus.value,
        widget.onActPress,
      );
    });
  }
}

Widget customAppbarAct(
  String? title,
  bool? noInternet,
  Function()? onActPress,
) {
  return AppBar(
    elevation: 0,
    // automaticallyImplyLeading: false,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        color: primaryAppColor,
        // gradient: LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   colors: [
        //     primaryColor,
        //     primaryColor.withOpacity(0.5),
        //   ],
        // ),
      ),
    ),
    actions: [
      noInternet!
          ? IconButton(
              onPressed: onActPress,
              icon: Icon(Icons.filter_list_outlined),
            )
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
        CommonText(text: "$title", color: white.withOpacity(0.8), fontSize: 18)
            .animate()
            .fadeIn(delay: 200.ms, duration: 200.ms)
            .slideY(duration: 200.ms),
    backgroundColor: transparent,
  );
}
