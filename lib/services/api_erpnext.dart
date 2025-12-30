// services/api_erpnext.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../utils/controllers/data_controller.dart';

class ApiErpnext {
  static String get baseUrl {
    try {
      final dataController = Get.find<DataController>();
      if (dataController.mySavedBaseURL.value.isNotEmpty &&
          dataController.mySavedBaseURL.value != "---") {
        return dataController.mySavedBaseURL.value;
      }
    } catch (e) {}
    return 'https://demo2.ababeel.ly';
  }

  static String? _cookie;
  static const Duration _timeout = Duration(seconds: 30);

  static Map<String, String> get headers {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      final dataController = Get.find<DataController>();
      print("mySavedSID: ${dataController.mySavedSID.value}");
      print("mySavedBaseURL: ${dataController.mySavedBaseURL.value}");
      if (dataController.mySavedSID.value.isNotEmpty &&
          dataController.mySavedSID.value != '- - -') {
        headers['Cookie'] = 'sid=${dataController.mySavedSID.value}';
        return headers;
      }
    } catch (e) {}

    if (_cookie != null) {
      headers['Cookie'] = _cookie!;
      print("Cookie: $_cookie");
    }

    return headers;
  }

  static void _checkLoginStatus() {
    try {
      final dataController = Get.find<DataController>();
      if (!dataController.loggedInStatus.value) {
        throw Exception('User not logged in. Please login first.');
      }
    } catch (e) {}
  }

  static void _handleSessionExpired() {
    try {
      final dataController = Get.find<DataController>();
      dataController.loggedInStatus.value = false;
      clearCookie();
    } catch (e) {}
  }

  static Future<http.Response> postForm(
    String endpoint,
    Map<String, String> body,
  ) async {
    _checkLoginStatus();

    final url = Uri.parse('$baseUrl$endpoint');
    final res = await http
        .post(
          url,
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          body: body,
        )
        .timeout(_timeout);

    saveAndStoreCookie(res.headers['set-cookie']);
    _handleResponse(res);
    return res;
  }

  static Future<http.Response> get(String endpoint) async {
    _checkLoginStatus();
    print("get ApiErpnext");


    final cleanBaseUrl = baseUrl.endsWith('/') 
        ? baseUrl.substring(0, baseUrl.length - 1) 
        : baseUrl;
    final cleanEndpoint = endpoint.startsWith('/') 
        ? endpoint 
        : '/$endpoint';

    final url = Uri.parse('$cleanBaseUrl$cleanEndpoint');
    print("URL: $url");
    print("Headers: $headers");
    final response = await http.get(url, headers: headers).timeout(_timeout);
    print("=======");
    print(response.body);
    print(response.statusCode);

    _handleResponse(response);
    return response;
  }

  static Future<http.Response> postJson(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    print("POST JSON ");
    _checkLoginStatus();

    final url = Uri.parse('$baseUrl$endpoint');
    final res = await http
        .post(url, headers: headers, body: jsonEncode(body))
        .timeout(_timeout);
    print("POST JSON Response: ${res.body}");
    print("POST JSON Status Code: ${res.statusCode}");

    saveAndStoreCookie(res.headers['set-cookie']);
    _handleResponse(res);
    return res;
  }

  static Future<http.Response> putJson(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    _checkLoginStatus();

    final url = Uri.parse('$baseUrl$endpoint');
    final res = await http
        .put(url, headers: headers, body: jsonEncode(body))
        .timeout(_timeout);

    saveAndStoreCookie(res.headers['set-cookie']);
    _handleResponse(res);
    return res;
  }

  static Future<http.Response> delete(String endpoint) async {
    _checkLoginStatus();

    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.delete(url, headers: headers).timeout(_timeout);

    _handleResponse(response);
    return response;
  }

  static Future<http.Response> patchJson(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    _checkLoginStatus();

    final url = Uri.parse('$baseUrl$endpoint');
    final res = await http
        .patch(url, headers: headers, body: jsonEncode(body))
        .timeout(_timeout);

    saveAndStoreCookie(res.headers['set-cookie']);
    _handleResponse(res);
    return res;
  }

  static Future<http.Response> uploadFile(
    File file, {
    String? fileName,
    Map<String, String>? additionalFields,
  }) async {
    _checkLoginStatus();

    final uri = Uri.parse('$baseUrl/api/method/upload_file');
    final request = http.MultipartRequest('POST', uri);

    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        file.path,
        filename: fileName ?? file.path.split('/').last,
      ),
    );

    if (additionalFields != null) {
      request.fields.addAll(additionalFields);
    }

    request.headers.addAll(headers);

    try {
      final streamedResponse = await request.send().timeout(_timeout);
      final response = await http.Response.fromStream(streamedResponse);
      saveAndStoreCookie(response.headers['set-cookie']);
      _handleResponse(response);
      return response;
    } catch (e) {
      throw Exception('فشل رفع الملف: $e');
    }
  }

  static void saveCookie(String? cookieHeader) {
    if (cookieHeader != null) {
      _cookie = cookieHeader.split(';').first;
    }
  }

  static Future<void> saveAndStoreCookie(String? cookieHeader) async {
    if (cookieHeader != null) {
      _cookie = cookieHeader.split(';').first;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('session_cookie', _cookie!);

      try {
        final dataController = Get.find<DataController>();
        if (_cookie!.contains('sid=')) {
          final sid = _cookie!.split('sid=').last.split(';').first;
          dataController.mySavedSID.value = sid;
          await prefs.setString('SID', sid);
        }
      } catch (e) {}
    }
  }

  static Future<void> loadCookieFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    _cookie = prefs.getString('session_cookie');

    try {
      final dataController = Get.find<DataController>();
      final sid = prefs.getString('SID');
      if (sid != null && sid.isNotEmpty) {
        dataController.mySavedSID.value = sid;
      }
    } catch (e) {}
  }

  static void clearCookie() {
    _cookie = null;

    try {
      final dataController = Get.find<DataController>();
      dataController.mySavedSID.value = '- - -';
    } catch (e) {}
  }

  static void _handleResponse(http.Response response) {
    if (response.statusCode == 401 || response.statusCode == 403) {
      _handleSessionExpired();
    }
  }

  static bool isSuccess(http.Response response) {
    return response.statusCode >= 200 && response.statusCode < 300;
  }

  static Map<String, dynamic>? parseJsonResponse(http.Response response) {
    try {
      return json.decode(response.body) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  static Future<void> setBaseUrl(String url) async {
    try {
      final dataController = Get.find<DataController>();
      dataController.mySavedBaseURL.value = url;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('baseUrl', url);
    } catch (e) {}
  }
}
