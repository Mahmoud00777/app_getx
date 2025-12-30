import 'package:http/http.dart' as http;
import '../../../services/api_erpnext.dart';

class BaseProvider {
  String _buildUrl(String endpoint, Map<String, dynamic>? query) {
    if (query == null || query.isEmpty) {
      return endpoint;
    }

    final uri = Uri.parse(endpoint);
    final queryParams = <String, String>{};

    for (var entry in query.entries) {
      final key = entry.key;
      final value = entry.value;

      if ((key == 'filters' || key == 'fields') && value is String) {
        queryParams[key] = value;
      } else {
        queryParams[key] = value.toString();
      }
    }

    final newUri = uri.replace(queryParameters: queryParams);
    return newUri.toString();
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (ApiErpnext.isSuccess(response)) {
      final jsonData = ApiErpnext.parseJsonResponse(response);

      if (jsonData == null) {
        return {'success': true, 'data': null};
      }

      if (jsonData.containsKey('data')) {
        return {'success': true, 'data': jsonData['data']};
      }

      return {'success': true, 'data': jsonData};
    } else {
      final errorData = ApiErpnext.parseJsonResponse(response);
      throw Exception(
        errorData?['message'] ??
            errorData?['_error_message'] ??
            'Request failed: ${response.statusCode}',
      );
    }
  }

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? query,
  }) async {
    try {
      final fullEndpoint = _buildUrl(endpoint, query);
      final response = await ApiErpnext.get(fullEndpoint);
      return _handleResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> post(
    String endpoint, {
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await ApiErpnext.postJson(endpoint, body);
      return _handleResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> put(
    String endpoint, {
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await ApiErpnext.putJson(endpoint, body);
      return _handleResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> patch(
    String endpoint, {
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await ApiErpnext.patchJson(endpoint, body);
      return _handleResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> delete(String endpoint) async {
    try {
      final response = await ApiErpnext.delete(endpoint);
      return _handleResponse(response);
    } catch (e) {
      rethrow;
    }
  }
}
