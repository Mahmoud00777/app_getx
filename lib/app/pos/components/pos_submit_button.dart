import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/pos_controller.dart';

class PosSubmitButton extends StatelessWidget {
  final PosController controller;

  const PosSubmitButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: controller.isSubmitting.value
                ? null
                : () => controller.submitOrder(),
            child: controller.isSubmitting.value
                ? CircularProgressIndicator()
                : Text('submitOrder'.tr),
          ),
        ),
      ),
    );
  }
}
