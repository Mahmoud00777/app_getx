class CustomerGroupModel {
  final String? customer_group;

  CustomerGroupModel({this.customer_group});

  factory CustomerGroupModel.fromJson(Map<String, dynamic> json) {
    return CustomerGroupModel(customer_group: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'name': customer_group};
  }

  CustomerGroupModel copyWith({String? customer_group}) {
    return CustomerGroupModel(
      customer_group: customer_group ?? this.customer_group,
    );
  }
}
