import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NetworkService {
  Future<Response> get(dynamic
  
   apiUrl, {dynamic headers}) {
    return http.get(apiUrl, headers: headers);
  }

  Future<Response> post(String _apiBaseUrl, dynamic data,
      {dynamic headers = const {"Content-Type": "application/json"}}) {
    return http.post(
      _apiBaseUrl,
      body: data,
      headers: headers,
    );
  }

  Map<String, dynamic> convertJsonToMap(String response) {
    return json.decode(response);
  }

  String getErrorMessage(dynamic exception) {
    String errorMessage;
    if (exception is SocketException) {
      errorMessage = exception.message;
    } else if (exception is TimeoutException) {
      errorMessage = exception.message;
    } else if (exception is HttpException) {
      errorMessage = exception.message;
    }

    return errorMessage;
  }
}
