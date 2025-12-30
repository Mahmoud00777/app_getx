class ItemModel {
  final String item_code;
  final String item_name;
  final String item_group;
  final String stock_uom;
  final double? price;
  final String? image;

  ItemModel({
    required this.item_code,
    required this.item_name,
    required this.item_group,
    required this.stock_uom,
    this.image,
    this.price,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      item_code: json['item_code'] ?? '',
      item_name: json['item_name'] ?? '',
      item_group: json['item_group'] ?? '',
      stock_uom: json['stock_uom'] ?? '',
      price: json['price'] ?? 0.0,
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item_code': item_code,
      'item_name': item_name,
      'item_group': item_group,
      'stock_uom': stock_uom,
      'price': price,
      'image': image,
    };
  }

  ItemModel copyWith({
    String? item_code,
    String? item_name,
    String? item_group,
    String? stock_uom,
    String? image,
    double? price,
  }) {
    return ItemModel(
      item_code: item_code ?? this.item_code,
      item_name: item_name ?? this.item_name,
      item_group: item_group ?? this.item_group,
      stock_uom: stock_uom ?? this.stock_uom,
      price: price ?? this.price,
      image: image ?? this.image,
    );
  }
}
