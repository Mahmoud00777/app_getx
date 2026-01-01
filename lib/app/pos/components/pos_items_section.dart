import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/pos_controller.dart';
import 'pos_item_card.dart';
import '../../../utils/constants.dart';

class PosItemsSection extends StatelessWidget {
  final PosController controller;

  const PosItemsSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: controller.searchController,
                    decoration: InputDecoration(
                      hintText: 'searchItems'.tr,
                      prefixIcon: Icon(Icons.search, color: primaryAppColor),
                      suffixIcon: Obx(() {
                        if (controller.searchQuery.value.isNotEmpty) {
                          return IconButton(
                            icon: Icon(Icons.clear, size: 20),
                            onPressed: () {
                              controller.searchController.clear();
                              controller.searchQuery.value = '';
                              controller.loadItems(reset: true);
                            },
                          );
                        }
                        return SizedBox.shrink();
                      }),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: white,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Obx(
                () => Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: white,
                    border: Border.all(color: greyShade300),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: DropdownButton<String>(
                    value: controller.selectedItemGroup.value.isEmpty
                        ? null
                        : controller.selectedItemGroup.value,
                    hint: Text('allGroups'.tr),
                    underline: SizedBox.shrink(),
                    isExpanded: false,
                    icon: Icon(Icons.filter_list, color: primaryAppColor),
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: primaryAppColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${controller.items.length} / ${controller.totalItems.value} ${'items'.tr}',
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryAppColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: greyShade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${'page'.tr} ${controller.currentPage.value} / ${controller.totalPages.value}',
                      style: TextStyle(
                        fontSize: 12,
                        color: greyShade600,
                      ),
                    ),
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
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.inventory_2_outlined,
                      size: 64,
                      color: greyShade600,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'noItemsFound'.tr,
                      style: TextStyle(
                        fontSize: 16,
                        color: greyShade600,
                      ),
                    ),
                  ],
                ),
              );
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
                  childAspectRatio: 0.65,
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
                  return PosItemCard(item: item, controller: controller);
                },
              ),
            );
          }),
        ),
      ],
    );
  }
}
