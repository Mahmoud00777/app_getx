class CustomerModel {
  final String id;
  final String name;
  final String? customer_type;
  final String? customer_group;

  CustomerModel({
    required this.id,
    required this.name,
    this.customer_type,
    this.customer_group,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['name'] ?? json['id'] ?? '',
      name: json['customer_name'] ?? json['name'] ?? '',
      customer_type: json['customer_type'],
      customer_group: json['customer_group'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': id,
      'customer_name': name,
      'customer_type': customer_type,
      'customer_group': customer_group,
    };
  }

  CustomerModel copyWith({
    String? id,
    String? name,
    String? customer_type,
    String? customer_group,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      customer_type: customer_type ?? this.customer_type,
      customer_group: customer_group ?? this.customer_group,
    );
  }
}
