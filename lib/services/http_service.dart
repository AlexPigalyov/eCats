import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:ecats/models/requests/request_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;
import 'package:ecats/assets/constants.dart' as Constants;

class HttpService {
  final _storage = const FlutterSecureStorage();

  Future<StreamedResponse> post<T extends RequestModel>(Uri uri, T body) async {
    var response = await _sendRequest('POST', uri, json.encode(body.toJson()));

    return response;
  }

  Future<StreamedResponse> get(Uri uri) async {
    var response = await _sendRequest('GET', uri, null);

    return response;
  }

  Future<StreamedResponse> _sendRequest(String method, Uri uri, String? jsonBody) async {
    var token = await _storage.read(key: 'token');
    var isApiUrl = uri.toString().contains(Constants.SERVER_URL);

    var request = http.Request(method, uri);

    request.headers.addAll(<String, String>{
      'Content-Type': 'application/json'
    });

    if(token != null && isApiUrl) {
      request.headers.addAll(<String, String> {
        'Authorization': 'Bearer $token'
      });
    }

    if(jsonBody != null) {
      request.body = jsonBody;
    }

    var response = await request.send();

    return response;
  }
}