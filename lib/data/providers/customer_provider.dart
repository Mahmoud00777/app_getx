import 'base_provider.dart';

class CustomerProvider extends BaseProvider {
  // - get()
  // - post()
  // - put()
  // - patch()
  // - delete()


  Future<Map<String, dynamic>> getCustomerByPhone(String phone) async {
    return await get(
      '/api/resource/Customer',
      query: {
        'filters': '[["mobile_no", "=", "$phone"]]',
      },
    );
  }
}