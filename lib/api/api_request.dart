import 'dart:async';
import 'dart:developer';

import '../utils/_local_storage.dart';
import 'api_status_code.dart';
import 'api_url.dart';
import 'package:http/http.dart' as http;

class APIRequestPlant {
  static Future<Map<String, dynamic>?> fetchRequests() async {
    //

    final url = Uri.parse('${BASE_URL}api/v1/requests');
    String accessToken = await getSessionToken() ?? '';

    //
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'ngrok-skip-browser-warning': 'true',
        'Authorization': 'Bearer $accessToken'
      });

      return await validateStatus(response);
    } catch (e) {
      log(': CLIENT ERROR', name: 'API', error: e);
      return null;
    }
  }
}
