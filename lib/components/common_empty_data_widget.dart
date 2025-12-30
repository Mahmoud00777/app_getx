import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CommonEmptyData extends StatelessWidget {
  const CommonEmptyData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 180,
            width: 180,

            child: Lottie.asset(
              'assets/animations/empty.json',
              repeat: false,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            "noData!".tr,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 5),
          Text(
            "noRecordFound".tr,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w200, fontSize: 14),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
