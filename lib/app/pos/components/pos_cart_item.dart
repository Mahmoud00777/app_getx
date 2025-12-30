import 'package:flutter/material.dart';
import 'package:pos_app/data/models/cart_item.dart';
import '../controller/pos_controller.dart';

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
    final price = cartItem.price.toStringAsFixed(2);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    itemName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${cartItem.quantity.toStringAsFixed(0)} x $price',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => controller.updateCartItemQuantity(
                    index,
                    cartItem.quantity - 1,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.remove, size: 18),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    cartItem.quantity.toStringAsFixed(0),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                  onTap: () => controller.updateCartItemQuantity(
                    index,
                    cartItem.quantity + 1,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.add, size: 18),
                  ),
                ),
                SizedBox(width: 4),
                InkWell(
                  onTap: () => controller.removeFromCart(index),
                  child: Container(
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.delete, size: 18, color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
