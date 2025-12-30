import 'package:flutter/material.dart';
import '../controller/pos_controller.dart';
import 'pos_customer_selector.dart';
import 'pos_cart_items_list.dart';
import 'pos_cart_summary.dart';
import 'pos_submit_button.dart';

class PosCartSection extends StatelessWidget {
  final PosController controller;

  const PosCartSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border(left: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Column(
        children: [
          PosCustomerSelector(controller: controller),
          Divider(),
          Expanded(child: PosCartItemsList(controller: controller)),
          Divider(),
          PosCartSummary(controller: controller),
          PosSubmitButton(controller: controller),
        ],
      ),
    );
  }
}
