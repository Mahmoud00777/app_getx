import 'package:pos_app/data/models/sales_order.dart';
import 'package:pos_app/data/repositories/base_repository.dart';




class SalesOrderRepository extends BaseRepository<SalesOrderModel>{
    SalesOrderRepository(): super(endpoint: '/api/resource/Sales Order');





@override
  SalesOrderModel fromJson(Map<String, dynamic> json) {
    return SalesOrderModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(SalesOrderModel model) {
    return model.toJson();
  }

}