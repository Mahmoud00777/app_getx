import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:pos_app/components/common_text.dart';
import 'package:pos_app/utils/constants.dart';

import '../utils/controllers/network_controller.dart';
import 'no_internet_dialog.dart';

// ignore: must_be_immutable
class CustomAppbarClass extends StatefulWidget {
  String title;
  Widget? action;
  CustomAppbarClass({required this.title, this.action, super.key});

  @override
  State<CustomAppbarClass> createState() => _CustomAppbarClassState();
}

class _CustomAppbarClassState extends State<CustomAppbarClass> {
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
      return AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(color: primaryAppColor),
        ),
        actions: [
          networkController.networkStatus.value
              ? widget.action ?? const SizedBox.shrink()
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
                  weight: FontWeight.w400,
                  fontSize: 14,
                )
                .animate()
                .fadeIn(delay: 200.ms, duration: 200.ms)
                .slideY(duration: 200.ms),
        backgroundColor: transparent,
      );
    });
  }
}

// Widget customAppbar(String? title, bool? noInternet) {
//   return AppBar(
//     elevation: 0,
//     // automaticallyImplyLeading: false,
//     flexibleSpace: Container(
//       decoration: BoxDecoration(color: primaryAppColor
//           // gradient: LinearGradient(
//           //   begin: Alignment.topCenter,
//           //   end: Alignment.bottomCenter,
//           //   colors: [
//           //     primaryColor,
//           //     primaryColor.withOpacity(0.5),
//           //   ],
//           // ),
//           ),
//     ),
//     actions: [
//       noInternet!
//           ? Container()
//           : Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Image(height: 26, image: AssetImage("assets/icons/no_wifi2.png")),
//             )
//     ],
//     centerTitle: true,
//     title: CommonText(text: "$title", color: white.withOpacity(0.8), weight: FontWeight.w400, fontSize: 14)
//         .animate()
//         .fadeIn(delay: 200.ms, duration: 200.ms)
//         .slideY(duration: 200.ms),
//     backgroundColor: transparent,
//   );
// }
