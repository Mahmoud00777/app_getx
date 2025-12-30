import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:pos_app/components/common_text.dart';
import 'package:pos_app/utils/constants.dart';

import '../utils/controllers/network_controller.dart';
import 'no_internet_dialog.dart';

// ignore: must_be_immutable
class CustomAppbarTabsClass extends StatefulWidget {
  String title;
  List<Widget> tabList = [];

  Function()? onActPress;
  bool? isAction = false;
  CustomAppbarTabsClass({
    required this.title,
    required this.tabList,
    this.onActPress,
    this.isAction,
    super.key,
  });

  @override
  State<CustomAppbarTabsClass> createState() => _CustomAppbarClassState();
}

class _CustomAppbarClassState extends State<CustomAppbarTabsClass> {
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
          networkController.networkStatus.value
              ? widget.isAction == false
                    ? Container()
                    : IconButton(
                        onPressed: widget.onActPress,
                        icon: Icon(Icons.filter_list_outlined),
                      )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Image(
                    height: 26,
                    image: AssetImage("assets/icons/no_wifi2.png"),
                  ),
                ),
          // : Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 20),
          //     child: Container(
          //         height: 30,
          //         width: 30,
          //         child: Lottie.asset('assets/animations/no_internet.json',
          //             fit: BoxFit.cover)))
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
        bottom: TabBar(
          automaticIndicatorColorAdjustment: false,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(20), // Creates border
            color: Colors.black12,
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: EdgeInsets.zero,
          unselectedLabelColor: Colors.white30,
          labelColor: white,
          padding: EdgeInsets.zero,
          labelPadding: EdgeInsets.zero,
          tabs: widget.tabList,
        ),
      );
    });
  }
}

// Widget customAppbarTabs(String? title, bool? noInternet, List<Widget> tabList) {
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
//               child: Image(
//                   height: 26, image: AssetImage("assets/icons/no_wifi2.png")),
//             )
//       // : Padding(
//       //     padding: const EdgeInsets.symmetric(horizontal: 20),
//       //     child: Container(
//       //         height: 30,
//       //         width: 30,
//       //         child: Lottie.asset('assets/animations/no_internet.json',
//       //             fit: BoxFit.cover)))
//     ],
//     centerTitle: true,
//     title: CommonText(
//       text: "$title",
//       color: white.withOpacity(0.8),
//       fontSize: 18,
//     )
//         .animate()
//         .fadeIn(delay: 200.ms, duration: 200.ms)
//         .slideY(duration: 200.ms),
//     backgroundColor: transparent,
//     bottom: TabBar(
//         automaticIndicatorColorAdjustment: false,
//         indicator: BoxDecoration(
//             borderRadius: BorderRadius.circular(20), // Creates border
//             color: Colors.black12),
//         indicatorSize: TabBarIndicatorSize.tab,
//         indicatorPadding: EdgeInsets.zero,
//         unselectedLabelColor: Colors.white30,
//         labelColor: white,
//         padding: EdgeInsets.zero,
//         labelPadding: EdgeInsets.zero,
//         tabs: tabList),
//   );
// }
