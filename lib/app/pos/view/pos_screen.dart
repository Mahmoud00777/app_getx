// lib/app/pos/view/pos_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/common_appbar.dart';
import '../controller/pos_controller.dart';
import '../components/pos_items_section.dart';
import '../components/pos_cart_section.dart';

class PosScreen extends StatelessWidget {
  final PosController controller = Get.find<PosController>();

  PosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: CustomAppbarClass(title: 'pos'.tr),
      ),
      body: Row(
        children: [
          Expanded(flex: 2, child: PosItemsSection(controller: controller)),
          Expanded(flex: 1, child: PosCartSection(controller: controller)),
        ],
      ),
    );
  }
}
