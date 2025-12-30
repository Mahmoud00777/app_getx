// lib/app/customer/controller/customers_controller.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/customer.dart';
import '../../../data/repositories/customers_repository.dart';
import '../../../data/models/customer_group.dart';
import '../../../data/repositories/customerGroup_repository.dart';

class CustomersController extends GetxController {
  final CustomersRepository _repository = CustomersRepository();
  final CustomerGroupRepository _customerGroupRepository =
      CustomerGroupRepository();
  final RxBool isLoadingCustomerGroups = false.obs;

  final RxList<CustomerModel> customers = <CustomerModel>[].obs;
  final RxList<CustomerGroupModel> customerGroups = <CustomerGroupModel>[].obs;
  final Rx<CustomerModel?> selectedCustomer = Rx<CustomerModel?>(null);
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;
  final RxBool isFiltered = false.obs;
  final RxInt currentPage = 0.obs;
  final RxInt pageSize = 20.obs;
  final RxBool hasMore = true.obs;
  final RxBool isLoadingMore = false.obs;

  final RxString selectedCustomerGroup = ''.obs;
  final RxString selectedCustomerType = ''.obs;
  static const List<String> customerTypes = [
    'Company',
    'Individual',
    'Partnership',
  ];

  late ScrollController scrollController;
  late TextEditingController searchController;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);

    searchController = TextEditingController();
    searchController.addListener(_onSearchChanged);
    loadCustomers();
    loadCustomerGroups();
  }

  @override
  void onClose() {
    searchController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void resetSelectedCustomerType() {
    selectedCustomerType.value = '';
  }

  void resetSelectedCustomerGroup() {
    selectedCustomerGroup.value = '';
  }

  void resetAllSelections() {
    resetSelectedCustomerGroup();
    resetSelectedCustomerType();
  }

  void _onSearchChanged() {
    final query = searchController.text;
    if (query.isEmpty) {
      loadCustomers();
    } else {
      searchCustomers(query);
    }
  }

  void clearSearch() {
    searchController.clear();
    loadCustomers();
  }

  void _onScroll() {
    if (scrollController.hasClients &&
        scrollController.position.pixels >=
            scrollController.position.maxScrollExtent * 0.9) {
      if (hasMore.value && !isLoadingMore.value && !isLoading.value) {
        loadMore();
      }
    }
  }

  Future<bool> createCustomer(CustomerModel customer) async {
    try {
      isLoading.value = true;

      // if (customer.phone != null && !customer.phone!.startsWith('218')) {
      //   Get.snackbar(
      //     'error'.tr,
      //     'phoneMustStartWith218'.tr,
      //     snackPosition: SnackPosition.BOTTOM,
      //   );
      //   return false;
      // }

      final createdCustomer = await _repository.create(customer);
      print("createdCustomer: $createdCustomer");
      customers.add(createdCustomer);

      Get.snackbar(
        'success'.tr,
        'customerCreated'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );

      return true;
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'failedToCreateCustomer'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadCustomerGroups() async {
    try {
      isLoadingCustomerGroups.value = true;
      customerGroups.value = await _customerGroupRepository.getAll();
      print("customerGroups/////////////: $customerGroups");
      print("customerGroups length/////////////: ${customerGroups.length}");
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'failedToLoadCustomerGroups'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoadingCustomerGroups.value = false;
    }
  }

  Future<void> loadCustomers() async {
    print("loadCustomers");
    try {
      isLoading.value = true;
      currentPage.value = 0;
      hasMore.value = true;
      isFiltered.value = false;

      customers.value = await _repository.getAll(
        limit: pageSize.value,
        start: 0,
        orderBy: 'creation desc',
        fields: ['name', 'customer_name', 'customer_type', 'customer_group'],
      );
      if (customers.length < pageSize.value) {
        hasMore.value = false;
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'failedToLoadCustomers'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore.value || !hasMore.value || isLoading.value) {
      return;
    }

    try {
      isLoadingMore.value = true;
      currentPage.value++;

      final start = currentPage.value * pageSize.value;
      print("🟢 Loading more - page: ${currentPage.value}, start: $start");

      final newCustomers = await _repository.getAll(
        limit: pageSize.value,
        start: start,
        orderBy: 'creation desc',
      );

      if (newCustomers.isEmpty) {
        hasMore.value = false;
        print("❌ No more customers to load");
      } else {
        customers.addAll(newCustomers);
        print(
          "✅ Loaded ${newCustomers.length} more customers (Total: ${customers.length})",
        );

        if (newCustomers.length < pageSize.value) {
          hasMore.value = false;
        }
      }
    } catch (e) {
      print("❌ Error loading more: $e");
      currentPage.value--;
      Get.snackbar(
        'error'.tr,
        'failedToLoadMore'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> loadCustomerById(String id) async {
    try {
      isLoading.value = true;

      selectedCustomer.value = await _repository.getById(id);
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'customerNotFound'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateCustomer(String id, CustomerModel customer) async {
    try {
      isLoading.value = true;

      // if (customer.phone != null && !customer.phone!.startsWith('218')) {
      //   Get.snackbar(
      //     'error'.tr,
      //     'phoneMustStartWith218'.tr,
      //     snackPosition: SnackPosition.BOTTOM,
      //   );
      //   return false;
      // }

      final updatedCustomer = await _repository.update(id, customer);

      final index = customers.indexWhere((c) => c.id == id);
      if (index != -1) {
        customers[index] = updatedCustomer;
      }

      Get.snackbar(
        'success'.tr,
        'customerUpdated'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );

      return true;
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'failedToUpdateCustomer'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteCustomer(String id) async {
    try {
      isLoading.value = true;

      final success = await _repository.delete(id);

      if (success) {
        customers.removeWhere((c) => c.id == id);

        Get.snackbar(
          'success'.tr,
          'customerDeleted'.tr,
          snackPosition: SnackPosition.BOTTOM,
        );
      }

      return success;
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'failedToDeleteCustomer'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchCustomers(String query) async {
    try {
      isLoading.value = true;
      searchQuery.value = query;
       isFiltered.value = false; 

      if (query.isEmpty) {
        // await loadCustomers();
        return;
      }
      currentPage.value = 0;
      hasMore.value = false;
      customers.value = await _repository.search(query);
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'searchFailed'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchByPhone(String phone) async {
    try {
      isLoading.value = true;

      final customer = await _repository.getByPhone(phone);

      if (customer != null) {
        selectedCustomer.value = customer;
      } else {
        Get.snackbar(
          'notFound'.tr,
          'customerNotFound'.tr,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadActiveCustomers() async {
    try {
      isLoading.value = true;

      customers.value = await _repository.getActiveCustomers();
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'failedToLoadCustomers'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> filterCustomers({
    String? customerType,
    String? customerGroup,
  }) async {
    try {
      isFiltered.value = true;
      isLoading.value = true;
      currentPage.value = 0;
      hasMore.value = false;
      List<List<dynamic>> filters = [];
      if (customerGroup != null && customerGroup.isNotEmpty) {
        filters.add(['customer_group', '=', customerGroup]);
      }

      if (customerType != null && customerType.isNotEmpty) {
        filters.add(['customer_type', '=', customerType]);
      }

      if (filters.isEmpty) {
        await loadCustomers();
        return;
      }
      customers.value = await _repository.getAll(
        filtersString: jsonEncode(filters),
        limit: pageSize.value,
        start: 0,
        orderBy: 'creation desc',
        fields: ['name', 'customer_name', 'customer_type', 'customer_group'],
      );
      if (customers.length < pageSize.value) {
        hasMore.value = false;
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'failedToFilterCustomers'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
