// lib/data/repositories/customers_repository.dart
import '../models/customer.dart';
import 'base_repository.dart';
import 'dart:convert';

class CustomersRepository extends BaseRepository<CustomerModel> {
  CustomersRepository() : super(endpoint: '/api/resource/Customer');

  @override
  CustomerModel fromJson(Map<String, dynamic> json) {
    return CustomerModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(CustomerModel model) {
    return model.toJson();
  }

  
  Future<CustomerModel?> getByPhone(String phone) async {
    try {
      if (!phone.startsWith('218')) {
          throw Exception('رقم الهاتف يجب أن يبدأ بـ 218');
      }

      
      final response = await provider.get(
        endpoint,
        query: {
          'filters': jsonEncode([['mobile_no', '=', phone]])
        },
      );
      
      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];
        if (data is List && data.isNotEmpty) {
         
          return fromJson(data[0]);
        }
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

 
  Future<CustomerModel?> getByEmail(String email) async {
    try {
      final response = await provider.get(
        endpoint,
        query: {
          'filters': jsonEncode([['email_id', '=', email]])
        },
      );
      
      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];
        if (data is List && data.isNotEmpty) {
          return fromJson(data[0]);
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  
  Future<List<CustomerModel>> getActiveCustomers() async {
   
    return getAll(filters: {
      'filters': jsonEncode([['disabled', '=', 0]])
    });
  }

 
  Future<List<CustomerModel>> getTopCustomers({int limit = 10}) async {
    try {
      final response = await provider.get(
        endpoint,
        query: {
          'order_by': 'total_sales desc',
          'limit': limit,
        },
      );

      if (response['success'] == true && response['data'] is List) {
        final data = response['data'] as List;
        return data.map((json) => fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}