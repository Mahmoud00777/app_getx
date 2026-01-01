// lib/app/pos/view/pos_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/pos_controller.dart';
import '../components/pos_items_section.dart';
import '../components/pos_cart_section.dart';
import '../../../utils/constants.dart';

class PosScreen extends StatelessWidget {
  final PosController controller = Get.find<PosController>();

  PosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryAppColor, primaryAppColorSd1],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: primaryAppColor.withOpacity(0.3),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              children: [
                IconButton(
        icon: Icon(Icons.arrow_back, color: white),
        onPressed: () => Get.back(),
      ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Icon(Icons.point_of_sale, color: white, size: 28),
                        SizedBox(width: 12),
                        Text(
                          'pos'.tr,
                          style: TextStyle(
                            color: white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Obx(() {
                          final cartQuantity = controller.cartItems.length;
                          final cartTotal = controller.cartItems.fold(
                            0.0,
                            (sum, item) => sum + item.subtotal,
                          );
                          
                          return Row(
                            children: [
                              _buildStatItem(
                                icon: Icons.shopping_cart,
                                value: cartQuantity.toString(),
                                label: 'items'.tr,
                              ),
                              SizedBox(width: 16),
                              _buildStatItem(
                                icon: Icons.attach_money,
                                value: cartTotal.toStringAsFixed(2),
                                label: 'total'.tr,
                                isTotal: true,
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Items Section - يأخذ كل المساحة
          Container(
            decoration: BoxDecoration(
              color: white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(2, 0),
                ),
              ],
            ),
            child: PosItemsSection(controller: controller),
          ),
          // Cart Panel - يظهر من الجانب
          Obx(() => _buildCartPanel()),
        ],
      ),
      floatingActionButton: Obx(() => _buildCartFAB()),
    );
  }

  Widget _buildCartPanel() {
    if (!controller.isCartVisible.value) {
      return SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () => controller.toggleCart(),
      child: Container(
        color: Colors.black.withOpacity(0.3),
        child: GestureDetector(
          onTap: () {}, // منع الإغلاق عند الضغط على السلة
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: MediaQuery.of(Get.context!).size.width * 0.45,
              constraints: BoxConstraints(maxWidth: 450),
              decoration: BoxDecoration(
                color: scaffoldBackground,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: Offset(-5, 0),
                  ),
                ],
              ),
              child: PosCartSection(controller: controller),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCartFAB() {
    final cartQuantity = controller.cartItems.length;
    final cartTotal = controller.cartItems.fold(
      0.0,
      (sum, item) => sum + item.subtotal,
    );

    return FloatingActionButton.extended(
      onPressed: () => controller.toggleCart(),
      backgroundColor: primaryAppColor,
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          Obx(() => Icon(
            controller.isCartVisible.value 
                ? Icons.close 
                : Icons.shopping_cart,
            color: white,
          )),
          if (cartQuantity > 0)
            Positioned(
              right: -8,
              top: -8,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: BoxConstraints(
                  minWidth: 20,
                  minHeight: 20,
                ),
                child: Text(
                  cartQuantity > 99 ? '99+' : cartQuantity.toString(),
                  style: TextStyle(
                    color: white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
      label: Obx(() => Text(
        controller.isCartVisible.value 
            ? 'hideCart'.tr 
            : 'showCart'.tr,
        style: TextStyle(color: white),
      )),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    bool isTotal = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: white, size: 18),
          SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: white,
                  fontSize: isTotal ? 16 : 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: white.withOpacity(0.9),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
