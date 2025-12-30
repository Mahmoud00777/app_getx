import 'sales_order_item.dart';

class SalesOrderModel {
  final String name;
  final String customer;
  final DateTime? date;
  final DateTime? delivery_date;
  final String selling_price_list;
  final String? set_warehouse;
  final List<SalesOrderItemModel>? items;
  final double? total_qty;
  final double? total;
  final double? net_total;
  final double? additional_discount_percentage;
  final double? discount_amount;

  SalesOrderModel({
    required this.name,
    required this.customer,
    this.date,
    this.delivery_date,
    required this.selling_price_list,
    this.set_warehouse,
    this.items,
    this.total_qty,
    this.total,
    this.net_total,
    this.additional_discount_percentage,
    this.discount_amount,
  });

  factory SalesOrderModel.fromJson(Map<String, dynamic> json) {
    DateTime? parsedDate;
  if (json['date'] != null) {
    if (json['date'] is String) {
      parsedDate = DateTime.tryParse(json['date']);
    } else if (json['date'] is DateTime) {
      parsedDate = json['date'] as DateTime;
    }
  }
  
  DateTime? parsedDeliveryDate;
  if (json['delivery_date'] != null) {
    if (json['delivery_date'] is String) {
      parsedDeliveryDate = DateTime.tryParse(json['delivery_date']);
    } else if (json['delivery_date'] is DateTime) {
      parsedDeliveryDate = json['delivery_date'] as DateTime;
    }
  }
  print("parsedDate: $parsedDate");
  print("parsedDeliveryDate: $parsedDeliveryDate");
    return SalesOrderModel(
      name: json['name'],
      customer: json['customer'],
      date: parsedDate,
      delivery_date: parsedDeliveryDate,
      selling_price_list: json['selling_price_list'],
      set_warehouse: json['set_warehouse'],
      items: json['items'] != null
          ? (json['items'] as List)
                .map((item) => SalesOrderItemModel.fromJson(item))
                .toList()
          : null,
      total_qty: json['total_qty'] != null
          ? (json['total_qty'] as num).toDouble()
          : null,
      total: json['total'] != null ? (json['total'] as num).toDouble() : null,
      net_total: json['net_total'] != null
          ? (json['net_total'] as num).toDouble()
          : null,
      additional_discount_percentage:
          json['additional_discount_percentage'] != null
          ? (json['additional_discount_percentage'] as num).toDouble()
          : null,
      discount_amount: json['discount_amount'] != null
          ? (json['discount_amount'] as num).toDouble()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
   String? dateString;
  if (date != null) {
    dateString = date!.toIso8601String().split('T')[0];
  }
  
  String? deliveryDateString;
  if (delivery_date != null) {
    deliveryDateString = delivery_date!.toIso8601String().split('T')[0];
  }
    return {
      'name': name,
      'customer': customer,
      'delivery_date': deliveryDateString,
      'selling_price_list': selling_price_list,
      'set_warehouse': set_warehouse,
      'customer': customer,
      'selling_price_list': selling_price_list,
      'set_warehouse': set_warehouse,
      'items': items?.map((item) => item.toJson()).toList(),
      'total_qty': total_qty,
      'total': total,
      'net_total': net_total,
      'additional_discount_percentage': additional_discount_percentage,
      'discount_amount': discount_amount,
    };
  }

  SalesOrderModel copyWith({
    String? name,
    String? customer,
    DateTime? date,
    String? selling_price_list,
    String? set_warehouse,
    List<SalesOrderItemModel>? items,
    double? total_qty,
    double? total,
    double? net_total,
    double? additional_discount_percentage,
    double? discount_amount,
  }) {
    return SalesOrderModel(
      name: name ?? this.name,
      customer: customer ?? this.customer,
      date: date ?? this.date,
      selling_price_list: selling_price_list ?? this.selling_price_list,
      set_warehouse: set_warehouse ?? this.set_warehouse,
      items: items ?? this.items,
      total_qty: total_qty ?? this.total_qty,
      total: total ?? this.total,
      net_total: net_total ?? this.net_total,
      additional_discount_percentage:
          additional_discount_percentage ?? this.additional_discount_percentage,
      discount_amount: discount_amount ?? this.discount_amount,
    );
  }
}
