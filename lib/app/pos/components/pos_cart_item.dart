import 'package:flutter/material.dart';
import 'package:pos_app/data/models/cart_item.dart';
import '../controller/pos_controller.dart';
import '../../../utils/constants.dart';

class PosCartItem extends StatelessWidget {
  final CartItemModel cartItem;
  final int index;
  final PosController controller;

  const PosCartItem({
    super.key,
    required this.cartItem,
    required this.index,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final itemName = cartItem.item.item_name.isNotEmpty
        ? cartItem.item.item_name
        : cartItem.item.item_code;
    final price = cartItem.price;
    final subtotal = cartItem.subtotal;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Item Name and Delete Button Row
            Row(
              children: [
                Expanded(
                  child: Text(
                    itemName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => controller.removeFromCart(index),
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Icons.delete_outline,
                        size: 16,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            // Price and Quantity Controls Row
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${price.toStringAsFixed(2)} x ${cartItem.quantity.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 10,
                          color: greyShade600,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        subtotal.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: primaryAppColor,
                        ),
                      ),
                    ],
                  ),
                ),
                // Quantity Controls
                Container(
                  decoration: BoxDecoration(
                    color: greyShade200,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildQuantityButton(
                        icon: Icons.remove,
                        onTap: () => controller.updateCartItemQuantity(
                          index,
                          cartItem.quantity - 1,
                        ),
                      ),
                      Container(
                        width: 28,
                        padding: EdgeInsets.symmetric(vertical: 4),
                        alignment: Alignment.center,
                        child: Text(
                          cartItem.quantity.toStringAsFixed(0),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildQuantityButton(
                        icon: Icons.add,
                        onTap: () => controller.updateCartItemQuantity(
                          index,
                          cartItem.quantity + 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: EdgeInsets.all(3),
          child: Icon(icon, size: 14, color: primaryAppColor),
        ),
      ),
    );
  }
}
