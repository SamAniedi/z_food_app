import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:z_food_app/utils/app_constants.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;
  late SharedPreferences sharedPreferences;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    baseUrl = appBaseUrl;
    token = sharedPreferences.getString(AppConstants.token)??"";
    timeout = const Duration(seconds: 30);
    _mainHeaders = {
      'Content-type': 'application/json; Charset = UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  // to update after registration
  void updateHeader(String token) {
    _mainHeaders = {
      'Content-type': 'application/json; Charset = UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getData(String uri,{ Map<String, String>? headers}) async {
    try {
      Response response = await get(uri,
      headers: headers??_mainHeaders);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body) async {
    if (kDebugMode) {
      print(body.toString());
    }
    try {
      Response response = await post(uri, body, headers: _mainHeaders);
      if (kDebugMode) {
        print(response.toString());
      }
      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString);
      }
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
