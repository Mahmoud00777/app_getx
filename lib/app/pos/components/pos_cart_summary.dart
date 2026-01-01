import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/pos_controller.dart';

class PosCartSummary extends StatelessWidget {
  final PosController controller;

  const PosCartSummary({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('total'.tr, style: TextStyle(fontSize: 18)),
                Text(
                  controller.cartTotal.toStringAsFixed(2),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('items'.tr),
                Text(controller.cartQuantity.toStringAsFixed(0)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
