import 'package:get/get.dart';
import '../controller/pos_controller.dart';
import 'package:pos_app/data/repositories/item_repository.dart';
import 'package:pos_app/data/repositories/customers_repository.dart';
import 'package:pos_app/data/repositories/item_group_repository.dart';
import 'package:pos_app/data/repositories/sales_order_repository.dart';

class PosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ItemRepository>(() => ItemRepository());
    Get.lazyPut<CustomersRepository>(() => CustomersRepository());
    Get.lazyPut<ItemGroupRepository>(() => ItemGroupRepository());
    Get.lazyPut<SalesOrderRepository>(() => SalesOrderRepository());
    Get.lazyPut<PosController>(() => PosController(
      itemRepository: Get.find<ItemRepository>(),
      customerRepository: Get.find<CustomersRepository>(),
      itemGroupRepository: Get.find<ItemGroupRepository>(),
      salesOrderRepository: Get.find<SalesOrderRepository>(),
    ));
  }
}