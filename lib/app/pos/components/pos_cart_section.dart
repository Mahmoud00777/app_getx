import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/pos_controller.dart';
import 'pos_customer_selector.dart';
import 'pos_cart_items_list.dart';
import 'pos_cart_summary.dart';
import 'pos_submit_button.dart';
import '../../../utils/constants.dart';

class PosCartSection extends StatelessWidget {
  final PosController controller;

  const PosCartSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: scaffoldBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(-2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryAppColor.withOpacity(0.1), transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.shopping_cart, color: primaryAppColor, size: 20),
                SizedBox(width: 6),
                Flexible(
                  child: Text(
                    'cart'.tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryAppColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Spacer(),
                Obx(() {
                  if (controller.cartItems.isNotEmpty) {
                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => _showClearCartDialog(),
                        borderRadius: BorderRadius.circular(4),
                        child: Container(
                          padding: EdgeInsets.all(6),
                          child: Icon(Icons.clear_all, color: Colors.red, size: 18),
                        ),
                      ),
                    );
                  }
                  return SizedBox.shrink();
                }),
                SizedBox(width: 4),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => controller.toggleCart(),
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      padding: EdgeInsets.all(6),
                      child: Icon(Icons.close, color: primaryAppColor, size: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1),
          // Customer Selector
          PosCustomerSelector(controller: controller),
          Divider(height: 1),
          // Cart Items
          Expanded(child: PosCartItemsList(controller: controller)),
          Divider(height: 1),
          // Summary
          PosCartSummary(controller: controller),
          Divider(height: 1),
          // Submit Button
          PosSubmitButton(controller: controller),
        ],
      ),
    );
  }

  void _showClearCartDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('clearCart'.tr),
        content: Text('areYouSureClearCart'.tr),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('cancel'.tr),
          ),
          TextButton(
            onPressed: () {
              controller.clearCart();
              Get.back();
            },
            child: Text('clear'.tr, style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
