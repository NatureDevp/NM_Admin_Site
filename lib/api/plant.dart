import 'dart:convert';
import 'dart:developer';

import 'url.dart';
import 'package:http/http.dart' as http;

class API {
  static Future<List?> getPlants() async {
    final url = Uri.parse('${BASE_URL}api/v1/plants');

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'ngrok-skip-browser-warning': 'true',
      });

      return _validateStatus(response);
    } catch (e) {
      print('Error: $e');
      throw Exception(e);
    }
  }

  static List? _validateStatus(http.Response response) {
    switch (response.statusCode) {
      case 200:
        log('[API] Plant fetched successfully');
        return jsonDecode(response.body)['data'];

      case 201:
        log('[API] Plant created successfully');
        return jsonDecode(response.body)['data'];

      case 204:
        log('[API] No content found');
        return null;

      case 400:
        log('[API] Bad Request');
        return null;

      case 401:
        log('[API] Unauthorized');
        return null;

      case 404:
        log('[API] Not Found');
        return null;

      case 500:
        log('[API] Internal Server Error');
        return null;

      default:
        log('[API] Service Unavailable');
        return null;
    }
  }
}
