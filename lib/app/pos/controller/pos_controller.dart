import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:pos_app/data/models/cart_item.dart';
import 'package:pos_app/data/models/customer.dart';
import 'package:pos_app/data/models/item.dart';
import 'package:pos_app/data/models/item_group.dart';
import 'package:pos_app/data/models/sales_order.dart';
import 'package:pos_app/data/models/sales_order_item.dart';
import 'package:pos_app/data/repositories/customers_repository.dart';
import 'package:pos_app/data/repositories/item_group_repository.dart';
import 'package:pos_app/data/repositories/item_repository.dart';
import 'package:pos_app/data/repositories/sales_order_repository.dart';

class PosController extends GetxController {
  final ItemRepository _itemRepository;
  final CustomersRepository _customerRepository;
  final ItemGroupRepository _itemGroupRepository;
  final SalesOrderRepository _salesOrderRepository;

  final RxList<ItemModel> items = <ItemModel>[].obs;
  final RxList<ItemGroupModel> itemGroups = <ItemGroupModel>[].obs;
  final RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final RxList<CustomerModel> customers = <CustomerModel>[].obs;
  final Rx<CustomerModel?> selectedCustomer = Rx<CustomerModel?>(null);
  final RxString searchQuery = ''.obs;
  final RxString selectedItemGroup = ''.obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingItemGroups = false.obs;
  final RxBool isLoadingCustomers = false.obs;
  final RxBool isSubmitting = false.obs;
  final RxBool isCartVisible = false.obs;

  final RxInt currentPage = 1.obs;
  final RxInt pageSize = 20.obs;
  final RxBool hasMore = true.obs;
  final RxBool isLoadingMore = false.obs;

  final RxInt totalItems = 0.obs;
  final RxInt totalPages = 0.obs;

  double get cartTotal {
    return cartItems.fold(0.0, (sum, item) => sum + item.subtotal);
  }

  double get cartQuantity {
    return cartItems.fold(0.0, (sum, item) => sum + item.quantity);
  }

  late TextEditingController searchController;

  PosController({required ItemRepository itemRepository, 
  required CustomersRepository customerRepository,
   required ItemGroupRepository itemGroupRepository,
    required SalesOrderRepository salesOrderRepository})
     : _itemRepository = itemRepository,
      _customerRepository = customerRepository,
       _itemGroupRepository = itemGroupRepository,
        _salesOrderRepository = salesOrderRepository;

  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
    searchController.addListener(_onSearchChanged);
    loadItems();
    loadItemsGroups();
    loadCustomers();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> loadItems({bool reset = true}) async {
    try {
      if (reset) {
        isLoading.value = true;
        currentPage.value = 1;
        hasMore.value = true;
      } else {
        isLoadingMore.value = true;
      }

      final search = searchQuery.value.isNotEmpty ? searchQuery.value : null;
      final itemGroup = selectedItemGroup.value.isNotEmpty
          ? selectedItemGroup.value
          : null;

      final result = await _itemRepository.getItemsFromCustomAPI(
        itemGroup: itemGroup,
        search: search,
        page: currentPage.value,
        limit: pageSize.value,
        orderBy: 'creation DESC',
      );

      final newItems = result['items'] as List<ItemModel>;
      final pagination = result['pagination'] as Map<String, dynamic>;

      if (pagination.isNotEmpty) {
        totalItems.value = pagination['total'] ?? 0;
        totalPages.value = pagination['total_pages'] ?? 0;
        final currentPageFromResponse = pagination['page'] ?? currentPage.value;

        hasMore.value = currentPageFromResponse < totalPages.value;

        print("📊 Pagination Info:");
        print("   - Current Page: $currentPageFromResponse");
        print("   - Total Pages: ${totalPages.value}");
        print("   - Total Items: ${totalItems.value}");
        print("   - Has More: ${hasMore.value}");
      } else {
        hasMore.value = newItems.length >= pageSize.value;
      }

      if (reset) {
        items.value = newItems;
      } else {
        items.addAll(newItems);
      }
    } catch (e) {
      Get.snackbar('error'.tr, e.toString());
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  Future<void> loadMoreItems() async {
    if (isLoadingMore.value || !hasMore.value || isLoading.value) {
      return;
    }

    currentPage.value++;
    await loadItems(reset: false);
  }

  Future<void> loadItemsGroups() async {
    try {
      isLoadingItemGroups.value = true;
      itemGroups.value = await _itemGroupRepository.getAll();
      print("itemGroups: $itemGroups");
      print("itemGroups length: ${itemGroups.length}");
    } catch (e) {
      Get.snackbar('error'.tr, e.toString());
    } finally {
      isLoadingItemGroups.value = false;
    }
  }

  Future<void> loadCustomers() async {
    try {
      isLoadingCustomers.value = true;
      customers.value = await _customerRepository.getAll();
      print("✅ Loaded ${customers.length} customers");
    } catch (e) {
      print("❌ Error loading customers: $e");
      Get.snackbar('error'.tr, 'failedToLoadCustomers'.tr);
    } finally {
      isLoadingCustomers.value = false;
    }
  }

  void _onSearchChanged() {
    searchQuery.value = searchController.text;
    currentPage.value = 1;

    Future.delayed(Duration(milliseconds: 500), () {
      if (searchQuery.value == searchController.text) {
        loadItems(reset: true);
      }
    });
  }

  void changeItemGroup(String? itemGroup) {
    selectedItemGroup.value = itemGroup ?? '';
    currentPage.value = 1;
    loadItems(reset: true);
  }

  void addToCart(ItemModel item, {double quantity = 1.0}) {
    final existingIndex = cartItems.indexWhere(
      (cartItem) => cartItem.item.item_code == item.item_code,
    );
    print("existingIndex: $existingIndex");

    if (existingIndex >= 0) {
      final existing = cartItems[existingIndex];
      cartItems[existingIndex] = existing.copyWith(
        quantity: existing.quantity + quantity,
      );
    } else {
      print("adding new item to cart");
      cartItems.add(
        CartItemModel(
          item: item,
          quantity: quantity,
          price: item.price ?? 0.0,
          uom: item.stock_uom,
        ),
      );
    }
  }

  void removeFromCart(int index) {
    cartItems.removeAt(index);
  }

  void updateCartItemQuantity(int index, double quantity) {
    if (quantity <= 0) {
      removeFromCart(index);
    } else {
      cartItems[index] = cartItems[index].copyWith(quantity: quantity);
    }
  }

  void clearCart() {
    cartItems.clear();
  }

  void toggleCart() {
    isCartVisible.value = !isCartVisible.value;
  }

  void selectCustomer(CustomerModel? customer) {
    selectedCustomer.value = customer;
  }

  Future<void> submitOrder() async {
    if (cartItems.isEmpty) {
      Get.snackbar('error'.tr, 'cartIsEmpty'.tr);
      return;
    }

    if (selectedCustomer.value == null) {
      Get.snackbar('error'.tr, 'pleaseSelectCustomer'.tr);
      return;
    }
    print("cartItems: $cartItems");
    print("selectedCustomer: ${selectedCustomer.value?.name}");
    print("isSubmitting: $isSubmitting");
    print(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));
    isSubmitting.value = true;
    try {
      final salesOrder = SalesOrderModel(
        name: '',
        customer: selectedCustomer.value!.name,
        selling_price_list: 'Standard Selling',
        delivery_date: DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        ),
        items: cartItems.map((cartItem) {
          return SalesOrderItemModel(
            item_code: cartItem.item.item_code,
            item_name: cartItem.item.item_name,
            qty: cartItem.quantity,
            price: cartItem.price,
            uom: cartItem.uom ?? cartItem.item.stock_uom,
          );
        }).toList(),
      );

      await _salesOrderRepository.create(salesOrder);

      Get.snackbar('success'.tr, 'orderCreatedSuccessfully'.tr);
      clearCart();
      selectedCustomer.value = null;
    } catch (e) {
      Get.snackbar('error'.tr, e.toString());
    } finally {
      isSubmitting.value = false;
    }
  }
}
