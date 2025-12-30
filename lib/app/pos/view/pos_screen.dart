// lib/app/pos/view/pos_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/common_appbar.dart';
import '../controller/pos_controller.dart';
import '../../../data/models/item.dart';
import '../../../data/models/cart_item.dart';

class PosScreen extends StatelessWidget {
  final PosController controller = Get.find<PosController>();

  PosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: CustomAppbarClass(title: 'pos'.tr),
      ),
      body: Row(
        children: [
          Expanded(flex: 2, child: _buildItemsSection()),
          Expanded(flex: 1, child: _buildCartSection()),
        ],
      ),
    );
  }

  Widget _buildItemsSection() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller.searchController,
                  decoration: InputDecoration(
                    hintText: 'searchItems'.tr,
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Obx(
                () => Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: DropdownButton<String>(
                    value: controller.selectedItemGroup.value.isEmpty
                        ? null
                        : controller.selectedItemGroup.value,
                    hint: Text('allGroups'.tr),
                    underline: SizedBox.shrink(),
                    isExpanded: false,
                    items: [
                      DropdownMenuItem<String>(
                        value: '',
                        child: Text('allGroups'.tr),
                      ),
                      ...controller.itemGroups.map((itemGroup) {
                        return DropdownMenuItem<String>(
                          value: itemGroup.name,
                          child: Text(
                            itemGroup.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }),
                    ],
                    onChanged: (value) {
                      controller.changeItemGroup(value);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Obx(() {
          if (controller.totalItems.value > 0) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${controller.items.length} / ${controller.totalItems.value} ${'items'.tr}',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    '${'page'.tr} ${controller.currentPage.value} / ${controller.totalPages.value}',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          return SizedBox.shrink();
        }),
        Expanded(
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }

            if (controller.items.isEmpty) {
              return Center(child: Text('noItemsFound'.tr));
            }

            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!controller.isLoadingMore.value &&
                    controller.hasMore.value &&
                    scrollInfo.metrics.pixels >=
                        scrollInfo.metrics.maxScrollExtent - 200) {
                  controller.loadMoreItems();
                }
                return false;
              },
              child: GridView.builder(
                padding: EdgeInsets.all(16.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemCount:
                    controller.items.length +
                    (controller.hasMore.value ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= controller.items.length) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  final item = controller.items[index];
                  return _buildItemCard(item);
                },
              ),
            );
          }),
        ),
      ],
    );
  }

  // ... rest of the code ...

  Widget _buildItemCard(ItemModel item) {
    return Card(
      child: InkWell(
        onTap: () => controller.addToCart(item),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Expanded(
            //   child: item.image != null
            //       ? Image.network(item.image!, fit: BoxFit.cover)
            //       : Icon(Icons.image, size: 50),
            // ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.item_name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    item.item_code,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border(left: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Column(
        children: [
          _buildCustomerSelector(),
          Divider(),
          Expanded(child: _buildCartItems()),
          Divider(),
          _buildCartSummary(),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildCustomerSelector() {
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

  Widget _buildCartItems() {
    return Obx(() {
      if (controller.cartItems.isEmpty) {
        return Center(child: Text('cartIsEmpty'.tr));
      }

      return ListView.builder(
        itemCount: controller.cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = controller.cartItems[index];
          return _buildCartItem(cartItem, index);
        },
      );
    });
  }

  Widget _buildCartItem(CartItemModel cartItem, int index) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    cartItem.item.item_name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  // Text(
                  //   '${cartItem.quantity} x ${cartItem.price.toStringAsFixed(2)}',
                  //   style: TextStyle(
                  //     fontSize: 12,
                  //     color: Colors.grey[600],
                  //   ),
                  // ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => controller.updateCartItemQuantity(
                    index,
                    cartItem.quantity - 1,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.remove, size: 18),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    cartItem.quantity.toStringAsFixed(0),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                  onTap: () => controller.updateCartItemQuantity(
                    index,
                    cartItem.quantity + 1,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.add, size: 14),
                  ),
                ),
                SizedBox(width: 4),
                InkWell(
                  onTap: () => controller.removeFromCart(index),
                  child: Container(
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.delete, size: 14, color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartSummary() {
    return Obx(
      () => Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('total'.tr, style: TextStyle(fontSize: 18)),
                Text(
                  controller.cartTotal.toStringAsFixed(2),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('items'.tr),
                Text(controller.cartQuantity.toStringAsFixed(0)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Obx(
      () => Padding(
        padding: EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: controller.isSubmitting.value
                ? null
                : () => controller.submitOrder(),
            child: controller.isSubmitting.value
                ? CircularProgressIndicator()
                : Text('submitOrder'.tr),
          ),
        ),
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
                        subtitle: Text(customer.name),
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
