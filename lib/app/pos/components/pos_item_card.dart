import 'package:flutter/material.dart';
import 'package:pos_app/data/models/item.dart';
import '../controller/pos_controller.dart';

class PosItemCard extends StatelessWidget {
  final ItemModel item;
  final PosController controller;

  const PosItemCard({super.key, required this.item, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => controller.addToCart(item),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.item_name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    item.item_code,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  if (item.price != null) ...[
                    SizedBox(height: 4),
                    // Text(
                    //   '${item.price!.toStringAsFixed(2)} ${item.currency ?? ''}',
                    //   style: TextStyle(
                    //     fontSize: 14,
                    //     fontWeight: FontWeight.bold,
                    //     color: Colors.green,
                    //   ),
                    // ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
