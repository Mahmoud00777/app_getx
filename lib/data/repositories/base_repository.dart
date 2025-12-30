// lib/data/repositories/base/base_repository.dart
import 'dart:convert';

import 'package:pos_app/data/providers/base_provider.dart';

abstract class BaseRepository<T> {
  final BaseProvider provider;
  final String endpoint;

  BaseRepository({BaseProvider? provider, required this.endpoint})
    : provider = provider ?? BaseProvider();

  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson(T model);

  Future<List<T>> getAll({
    Map<String, dynamic>? filters,
     String? filtersString,
    int? limit = 0,
    int? start = 0,
    String? orderBy,
    List<String>? fields,
  }) async {
    print("BaseRepository getAll");

    try {
      Map<String, dynamic> queryParams = {};
      if (filtersString != null) {
        queryParams['filters'] = filtersString;
      }
      if (filters != null) {
        queryParams['filters'] = filters;
      }
      if (limit != null) {
        queryParams['limit'] = limit;
      }
      if (start != null) {
        queryParams['start'] = start;
      }
      if (orderBy != null) {
        queryParams['order_by'] = orderBy;
      }
      if (fields != null && fields.isNotEmpty) {
        queryParams['fields'] = jsonEncode(fields);
      }
      print("BaseRepository getAll - queryParams: $queryParams");
      final response = await provider.get(endpoint, query: queryParams);
      print("-----");
      print(response);
      if (response['success'] == true) {
        final data = response['data'];
        if (data is List) {
          return data
              .map((json) => fromJson(Map<String, dynamic>.from(json as Map)))
              .toList();
        } else if (data is Map) {
          return [fromJson(Map<String, dynamic>.from(data))];
        }
        return [];
      } else {
        throw Exception(response['message'] ?? 'Failed to fetch data');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<T> getById(String id) async {
    try {
      final response = await provider.get('$endpoint/$id');

      if (response['success'] == true) {
        return fromJson(Map<String, dynamic>.from(response['data'] as Map));
      } else {
        throw Exception(response['message'] ?? 'Failed to fetch data');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<T> create(T model) async {
    try {
      print("BaseRepository create - endpoint: $endpoint");
      final response = await provider.post(endpoint, body: toJson(model));
      print("BaseRepository create - response: $response");

      if (response['success'] == true) {
        final data = response['data'];
        print("BaseRepository create - data: $data");

        if (data is Map) {
          return fromJson(Map<String, dynamic>.from(data));
        } else {
          throw Exception('Invalid response format: data is not a Map');
        }
      } else {
        final errorMsg = response['message'] ?? 'Failed to create';
        print("BaseRepository create - error: $errorMsg");
        throw Exception(errorMsg);
      }
    } catch (e) {
      print("BaseRepository create - exception: $e");
      rethrow;
    }
  }

  Future<T> update(String id, T model) async {
    try {
      final response = await provider.put('$endpoint/$id', body: toJson(model));

      if (response['success'] == true) {
        return fromJson(Map<String, dynamic>.from(response['data'] as Map));
      } else {
        throw Exception(response['message'] ?? 'Failed to update');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> delete(String id) async {
    try {
      print("BaseRepository delete - endpoint: $endpoint");
      final response = await provider.delete('$endpoint/$id');
      print("BaseRepository delete - response: $response");

      return response['success'] == true;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<T>> search(String query, {String? field}) async {
    try {
      final searchField = field ?? 'name';

      final response = await provider.get(
        endpoint,
        query: {
          'filters': jsonEncode([
            [searchField, 'like', '%$query%'],
          ]),
        },
      );

      if (response['success'] == true) {
        final data = response['data'];
        if (data is List) {
          return data
              .map((json) => fromJson(Map<String, dynamic>.from(json as Map)))
              .toList();
        }
        return [];
      } else {
        throw Exception(response['message'] ?? 'Failed to search');
      }
    } catch (e) {
      rethrow;
    }
  }
}
