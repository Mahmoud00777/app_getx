// lib/app/customer/view/customer_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/components/common_appbar.dart';
import '../controller/customers_controller.dart';
import '../../../data/models/customer.dart';
import '../../../components/common_text.dart';
import '../../../components/common_button.dart';
import '../../../components/common_search_field.dart';
import '../../../components/common_empty_data_widget.dart';
import '../../../utils/constants.dart';

class CustomerScreen extends StatelessWidget {
  final CustomersController controller = Get.find<CustomersController>();

  CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: CustomAppbarClass(
          title: 'customers'.tr,
          action: Obx(
            () => Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  onPressed: () => _showFilterDialog(),
                  icon: Icon(Icons.filter_list_outlined),
                ),
                if (controller.isFiltered.value)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: SearchBox(
              hint: 'customers'.tr,
              searchController: controller.searchController,
              onSub: (value) => controller.searchCustomers(value),
              onChange: (value) {
                if (value.isEmpty) {
                  controller.loadCustomers();
                } else {
                  controller.searchCustomers(value);
                }
              },
              onCancel: () {
                controller.clearSearch();
                controller.loadCustomers();
              },
            ),
          ),

          SizedBox(height: 16),

          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              if (controller.customers.isEmpty) {
                return CommonEmptyData();
              }

              return RefreshIndicator(
                onRefresh: () => controller.loadCustomers(),
                child: ListView.builder(
                  controller: controller.scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount:
                      controller.customers.length +
                      (controller.hasMore.value ||
                              controller.isLoadingMore.value
                          ? 1
                          : 0),

                  itemBuilder: (context, index) {
                    if (index == controller.customers.length) {
                      return _buildLoadMoreWidget();
                    }
                    final customer = controller.customers[index];
                    return _buildCustomerCard(customer);
                  },
                ),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCustomerDialog(),
        backgroundColor: primaryAppColor,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildLoadMoreWidget() {
    return Obx(() {
      if (controller.isLoadingMore.value) {
        return Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 8),
                CommonText(text: 'loading'.tr, fontSize: 14, color: grey),
              ],
            ),
          ),
        );
      }

      if (controller.hasMore.value) {
        return Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: CommonButton(
              text: 'loadMore'.tr,
              height: 40,
              onPress: () => controller.loadMore(),
            ),
          ),
        );
      }

      return SizedBox.shrink();
    });
  }

  Widget _buildCustomerCard(CustomerModel customer) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _showCustomerDetails(customer),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: primaryAppColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.person, color: primaryAppColor, size: 30),
                  ),
                  SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: customer.name,
                          fontSize: 16,
                          weight: FontWeight.bold,
                          color: black,
                        ),
                        CommonText(
                          text: customer.customer_type ?? '',
                          fontSize: 14,
                          color: black,
                        ),
                        CommonText(
                          text: customer.customer_group ?? '',
                          fontSize: 14,
                          color: grey,
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  ),
                ],
              ),

              SizedBox(height: 12),
              Divider(),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _showEditCustomerDialog(customer),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _showDeleteDialog(customer),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        SizedBox(width: 8),
        Expanded(
          child: CommonText(text: text, fontSize: 13, color: grey),
        ),
      ],
    );
  }

  void _showAddCustomerDialog() {
    final nameController = TextEditingController();
    controller.resetAllSelections();

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: 'addCustomer'.tr,
                  fontSize: 20,
                  weight: FontWeight.bold,
                ),
                SizedBox(height: 20),

                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'name'.tr,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                Obx(() {
                  return DropdownButtonFormField<String>(
                    initialValue: controller.selectedCustomerType.value.isEmpty
                        ? null
                        : controller.selectedCustomerType.value,
                    decoration: InputDecoration(
                      labelText: 'customerType'.tr,
                      border: OutlineInputBorder(),
                    ),
                    items: CustomersController.customerTypes.map((type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.selectedCustomerType.value = value ?? '';
                    },
                  );
                }),
                SizedBox(height: 12),
                Obx(() {
                  if (controller.isLoadingCustomerGroups.value) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (controller.customerGroups.isEmpty) {
                    return DropdownButtonFormField<String>(
                      initialValue: null,
                      decoration: InputDecoration(
                        labelText: 'customerGroup'.tr,
                        border: OutlineInputBorder(),
                      ),
                      items: [],
                      onChanged: null,
                    );
                  }

                  return DropdownButtonFormField<String>(
                    initialValue: controller.selectedCustomerGroup.value.isEmpty
                        ? null
                        : controller.selectedCustomerGroup.value,
                    decoration: InputDecoration(
                      labelText: 'customerGroup'.tr,
                      border: OutlineInputBorder(),
                    ),
                    items: controller.customerGroups.map((group) {
                      return DropdownMenuItem<String>(
                        value: group.customer_group,
                        child: Text(group.customer_group ?? ''),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.selectedCustomerGroup.value = value ?? '';
                    },
                  );
                }),
                SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () {
                              controller.resetSelectedCustomerGroup();
                              Get.back();
                            },
                      child: Text('cancel'.tr),
                    ),
                    SizedBox(width: 8),
                    Obx(() {
                      if (controller.isLoading.value) {
                        return Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                CommonText(
                                  text: 'saving'.tr,
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return CommonButton(
                        text: 'save'.tr,
                        height: 40,
                        width: 100,
                        onPress: () async {
                          if (nameController.text.isEmpty) {
                            Get.snackbar('error'.tr, 'pleaseEnterName'.tr);
                            return;
                          }

                          final customer = CustomerModel(
                            id: '',
                            name: nameController.text,
                            customer_group:
                                controller.selectedCustomerGroup.value.isEmpty
                                ? null
                                : controller.selectedCustomerGroup.value,
                            customer_type:
                                controller.selectedCustomerType.value.isEmpty
                                ? null
                                : controller.selectedCustomerType.value,
                          );

                          final success = await controller.createCustomer(
                            customer,
                          );
                          if (success) {
                            controller.resetAllSelections();
                            Navigator.of(Get.context!).pop();
                            controller.loadCustomers();
                          }
                        },
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEditCustomerDialog(CustomerModel customer) {
    final nameController = TextEditingController(text: customer.name);
    controller.selectedCustomerType.value = customer.customer_type ?? '';
    controller.selectedCustomerGroup.value = customer.customer_group ?? '';
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: 'editCustomer'.tr,
                  fontSize: 20,
                  weight: FontWeight.bold,
                ),
                SizedBox(height: 20),

                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'name'.tr,
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: 12),

                Obx(() {
                  return DropdownButtonFormField<String>(
                    initialValue: controller.selectedCustomerType.value.isEmpty
                        ? null
                        : controller.selectedCustomerType.value,
                    decoration: InputDecoration(
                      labelText: 'customerType'.tr,
                      border: OutlineInputBorder(),
                    ),
                    items: CustomersController.customerTypes.map((type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.selectedCustomerType.value = value ?? '';
                    },
                  );
                }),
                SizedBox(height: 12),

                Obx(() {
                  if (controller.isLoadingCustomerGroups.value) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (controller.customerGroups.isEmpty) {
                    return DropdownButtonFormField<String>(
                      initialValue: null,
                      decoration: InputDecoration(
                        labelText: 'customerGroup'.tr,
                        border: OutlineInputBorder(),
                      ),
                      items: [],
                      onChanged: null,
                    );
                  }

                  final currentValue = controller.selectedCustomerGroup.value;
                  final selectedValue = (currentValue.isEmpty)
                      ? null
                      : currentValue;

                  if (selectedValue == null && currentValue.isNotEmpty) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      controller.selectedCustomerGroup.value = '';
                    });
                  }

                  return DropdownButtonFormField<String>(
                    initialValue: selectedValue,
                    decoration: InputDecoration(
                      labelText: 'customerGroup'.tr,
                      border: OutlineInputBorder(),
                    ),
                    items: controller.customerGroups.map((group) {
                      return DropdownMenuItem<String>(
                        value: group.customer_group!,
                        child: Text(group.customer_group!),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.selectedCustomerGroup.value = value ?? '';
                    },
                  );
                }),
                // Obx(() {
                //   if (controller.isLoading.value) {
                //     return Padding(
                //       padding: EdgeInsets.symmetric(vertical: 8),
                //       child: Center(
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             SizedBox(
                //               width: 16,
                //               height: 16,
                //               child: CircularProgressIndicator(strokeWidth: 2),
                //             ),
                //             SizedBox(width: 8),
                //             CommonText(
                //               text: 'updating'.tr,
                //               fontSize: 14,
                //               color: grey,
                //             ),
                //           ],
                //         ),
                //       ),
                //     );
                //   }
                //   return SizedBox.shrink();
                // }),
                SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () {
                              controller.resetAllSelections();
                              Get.back();
                            },
                      child: Text('cancel'.tr),
                    ),
                    SizedBox(width: 8),
                    Obx(() {
                      if (controller.isLoading.value) {
                        return Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                CommonText(
                                  text: 'updating'.tr,
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return CommonButton(
                        text: 'update'.tr,
                        height: 40,
                        width: 100,
                        onPress: () async {
                          if (nameController.text.isEmpty) {
                            Get.snackbar('error'.tr, 'pleaseEnterName'.tr);
                            return;
                          }
                          final updatedCustomer = customer.copyWith(
                            name: nameController.text,
                            customer_type:
                                controller.selectedCustomerType.value.isEmpty
                                ? null
                                : controller.selectedCustomerType.value,
                            customer_group:
                                controller.selectedCustomerGroup.value.isEmpty
                                ? null
                                : controller.selectedCustomerGroup.value,
                          );

                          final success = await controller.updateCustomer(
                            customer.id,
                            updatedCustomer,
                          );
                          if (success) {
                            controller.resetAllSelections();
                            Navigator.of(Get.context!).pop();
                            controller.loadCustomers();
                          }
                        },
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCustomerDetails(CustomerModel customer) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CommonText(
                        text: 'customerDetails'.tr,
                        fontSize: 20,
                        weight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                _buildDetailRow('customerName'.tr, customer.name),
                _buildDetailRow(
                  'customerType'.tr,
                  customer.customer_type ?? '',
                ),
                _buildDetailRow(
                  'customerGroup'.tr,
                  customer.customer_group ?? '',
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text('close'.tr),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: CommonText(
              text: label,
              fontSize: 14,
              weight: FontWeight.bold,
              color: grey,
            ),
          ),
          Expanded(
            child: CommonText(text: value, fontSize: 14, color: black),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(CustomerModel customer) {
    Get.dialog(
      AlertDialog(
        title: CommonText(
          text: 'confirmation'.tr,
          fontSize: 18,
          weight: FontWeight.bold,
        ),
        content: CommonText(
          text: 'areYouSureYouWantToDelete${customer.name}'.tr,
          fontSize: 14,
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('cancel'.tr)),
          TextButton(
            onPressed: () async {
              Get.back();
              final success = await controller.deleteCustomer(customer.id);
            },
            child: Text('delete'.tr, style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: 'filterCustomers'.tr,
                  fontSize: 20,
                  weight: FontWeight.bold,
                ),
                TextButton(
                  onPressed: () {
                    controller.resetAllSelections();
                    controller.loadCustomers();
                    Get.back();
                  },
                  child: Text('reset'.tr),
                ),
              ],
            ),
            SizedBox(height: 20),
            CommonText(
              text: 'customerGroup'.tr,
              fontSize: 16,
              weight: FontWeight.bold,
            ),
            SizedBox(height: 10),
            Obx(() {
              if (controller.isLoadingCustomerGroups.value) {
                return CircularProgressIndicator();
              }
              return DropdownButtonFormField<String>(
                initialValue: controller.selectedCustomerGroup.value.isEmpty
                    ? null
                    : controller.selectedCustomerGroup.value,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'selectCustomerGroup'.tr,
                ),
                items: [
                  DropdownMenuItem(value: null, child: Text('all'.tr)),
                  ...controller.customerGroups.map((group) {
                    return DropdownMenuItem<String>(
                      value: group.customer_group,
                      child: Text(group.customer_group ?? ''),
                    );
                  }),
                ],
                onChanged: (value) {
                  controller.selectedCustomerGroup.value = value ?? '';
                },
              );
            }),
            SizedBox(height: 20),
            CommonText(
              text: 'customerType'.tr,
              fontSize: 16,
              weight: FontWeight.bold,
            ),
            SizedBox(height: 10),
            Obx(() {
              return DropdownButtonFormField<String>(
                initialValue: controller.selectedCustomerType.value.isEmpty
                    ? null
                    : controller.selectedCustomerType.value,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'selectCustomerType'.tr,
                ),
                items: [
                  DropdownMenuItem(value: null, child: Text('all'.tr)),
                  ...CustomersController.customerTypes.map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }),
                ],
                onChanged: (value) {
                  controller.selectedCustomerType.value = value ?? '';
                },
              );
            }),
            SizedBox(height: 20),
            CommonButton(
              text: 'applyFilter'.tr,
              height: 40,
              onPress: () {
                controller.filterCustomers(
                  customerType: controller.selectedCustomerType.value.isEmpty
                      ? null
                      : controller.selectedCustomerType.value,
                  customerGroup: controller.selectedCustomerGroup.value.isEmpty
                      ? null
                      : controller.selectedCustomerGroup.value,
                );
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
