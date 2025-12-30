import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/pos_controller.dart';
import 'pos_item_card.dart';

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
