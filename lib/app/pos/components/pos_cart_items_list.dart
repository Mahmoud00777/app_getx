import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/pos_controller.dart';
import 'pos_cart_item.dart';

class PosCartItemsList extends StatelessWidget {
  final PosController controller;

  const PosCartItemsList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.cartItems.isEmpty) {
        return Center(child: Text('cartIsEmpty'.tr));
      }

      return ListView.builder(
        itemCount: controller.cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = controller.cartItems[index];
          return PosCartItem(
            cartItem: cartItem,
            index: index,
            controller: controller,
          );
        },
      );
    });
  }
}
