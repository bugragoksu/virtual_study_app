import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../agora_config.dart';

class HttpService {
  HttpService._privateConstructor();

  static final HttpService _instance = HttpService._privateConstructor();

  static HttpService get instance => _instance;

  final String _baseUrl = TOKEN_SERVER_API;

  Future<String> getToken(
      {required String channelName, required String uid}) async {
    final response = await http
        .get(Uri.parse(_baseUrl + channelName + '/publisher/userAccount/$uid'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['rtcToken'];
    }
    return "";
  }
}
