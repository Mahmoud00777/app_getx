import 'package:pos_app/data/models/item.dart';

class CartItemModel {
  final ItemModel item;
  final double quantity;
  final double price;
  final double? discount;
  final String? uom;

  CartItemModel({
    required this.item,
    required this.quantity,
    required this.price,
    this.discount,
    this.uom,
  });

  double get subtotal => (price * quantity) - (discount ?? 0);

  CartItemModel copyWith({
    ItemModel? item,
    double? quantity,
    double? price,
    double? discount,
    String? uom,
  }) {
    return CartItemModel(
      item: item ?? this.item,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      uom: uom ?? this.uom,
    );
  }
}
