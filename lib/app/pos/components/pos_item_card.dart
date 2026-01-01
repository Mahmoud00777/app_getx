import 'package:flutter/material.dart';
import 'package:pos_app/data/models/item.dart';
import '../controller/pos_controller.dart';
import '../../../utils/constants.dart';

class PosItemCard extends StatelessWidget {
  final ItemModel item;
  final PosController controller;

  const PosItemCard({super.key, required this.item, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => controller.addToCart(item),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: greyShade300, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image Section
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: greyShade200,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child:
                      (item.image != null &&
                          item.image!.isNotEmpty &&
                          item.image != '')
                      ? ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          child: Image.network(
                            item.image!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildPlaceholder(),
                          ),
                        )
                      : _buildPlaceholder(),
                ),
              ),
              // Content Section
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          item.item_name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: black,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        item.item_code,
                        style: TextStyle(
                          fontSize: 10,
                          color: greyShade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Spacer(),
                      if (item.price != null && item.price! > 0)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: primaryAppColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            item.price!.toStringAsFixed(2),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: primaryAppColor,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Center(
      child: Icon(Icons.inventory_2_outlined, size: 20, color: greyShade600),
    );
  }
}
