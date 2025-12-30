// lib/data/models/sales_order_item.dart
class SalesOrderItemModel {
  final String item_code;
  final String? item_name;
  final double qty;
  final double? price;
  final double? amount;
  final String? uom;
  final String? warehouse;
  final double? discount_percentage;
  final double? discount_amount;
  final String? description;

  SalesOrderItemModel({
    required this.item_code,
    this.item_name,
    required this.qty,
    this.price,
    this.amount,
    this.uom,
    this.warehouse,
    this.discount_percentage,
    this.discount_amount,
    this.description,
  });

  factory SalesOrderItemModel.fromJson(Map<String, dynamic> json) {
    return SalesOrderItemModel(
      item_code: json['item_code'] ?? '',
      item_name: json['item_name'],
      qty: (json['qty'] ?? 0).toDouble(),
      price: json['rate'] != null ? (json['rate'] as num).toDouble() : null,
      amount: json['amount'] != null
          ? (json['amount'] as num).toDouble()
          : null,
      uom: json['uom'] ?? json['stock_uom'],
      warehouse: json['warehouse'],
      discount_percentage: json['discount_percentage'] != null
          ? (json['discount_percentage'] as num).toDouble()
          : null,
      discount_amount: json['discount_amount'] != null
          ? (json['discount_amount'] as num).toDouble()
          : null,
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    
    return {
      'item_code': item_code,
      'item_name': item_name,
      'qty': qty,
      'rate': price,
      'amount': amount,
      'uom': uom,
      'warehouse': warehouse,
      'discount_percentage': discount_percentage,
      'discount_amount': discount_amount,
      'description': description,
    };
  }

  SalesOrderItemModel copyWith({
    String? item_code,
    String? item_name,
    double? qty,
    double? rate,
    double? amount,
    String? uom,
    String? warehouse,
    double? discount_percentage,
    double? discount_amount,
    String? description,
  }) {
    return SalesOrderItemModel(
      item_code: item_code ?? this.item_code,
      item_name: item_name ?? this.item_name,
      qty: qty ?? this.qty,
      price: price ?? price,
      amount: amount ?? this.amount,
      uom: uom ?? this.uom,
      warehouse: warehouse ?? this.warehouse,
      discount_percentage: discount_percentage ?? this.discount_percentage,
      discount_amount: discount_amount ?? this.discount_amount,
      description: description ?? this.description,
    );
  }
}
