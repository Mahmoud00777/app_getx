import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../../components/common_appbar.dart";

class OTPLoginScreen extends StatefulWidget {
  const OTPLoginScreen({super.key});

  @override
  State<OTPLoginScreen> createState() => _OTPLoginScreenState();
}

class _OTPLoginScreenState extends State<OTPLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: CustomAppbarClass(title: 'otpLoginScreen'.tr),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
