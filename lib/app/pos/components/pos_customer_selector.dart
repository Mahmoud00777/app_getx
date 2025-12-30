import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/pos_controller.dart';

class PosCustomerSelector extends StatelessWidget {
  final PosController controller;

  const PosCustomerSelector({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListTile(
        title: Text('customer'.tr),
        subtitle: Text(
          controller.selectedCustomer.value?.name ?? 'selectCustomer'.tr,
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => _showCustomerSelector(),
      ),
    );
  }

  void _showCustomerSelector() {
    showDialog(
      context: Get.context!,
      builder: (context) => Dialog(
        child: SizedBox(
          width: 500,
          height: 600,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'selectCustomer'.tr,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
              ),
              Divider(),
              Expanded(
                child: Obx(() {
                  if (controller.isLoadingCustomers.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (controller.customers.isEmpty) {
                    return Center(child: Text('noCustomersFound'.tr));
                  }

                  return ListView.builder(
                    itemCount: controller.customers.length,
                    itemBuilder: (context, index) {
                      final customer = controller.customers[index];
                      final isSelected =
                          controller.selectedCustomer.value?.name ==
                          customer.name;

                      return ListTile(
                        title: Text(customer.name),
                        subtitle: Text(customer.name ?? ''),
                        selected: isSelected,
                        trailing: isSelected
                            ? Icon(Icons.check, color: Colors.green)
                            : null,
                        onTap: () {
                          controller.selectCustomer(customer);
                          Get.back();
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
