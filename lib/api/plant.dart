import 'dart:async';
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
      log(': CLIENT/SERVER ERROR', name: 'API', error: e, level: 100);
      return null;
      // throw Exception(e);
    }
  }

  static List? _validateStatus(http.Response response) {
    switch (response.statusCode) {
      case 200:
        log('Plant fetched successfully', name: 'API');
        return jsonDecode(response.body)['data'];

      case 201:
        log('Plant created successfully', name: 'API');
        return jsonDecode(response.body)['data'];

      case 204:
        log('No content found', name: 'API');
        return null;

      case 400:
        log('Bad Request', name: 'API');
        return null;

      case 401:
        log('Unauthorized', name: 'API');
        return null;

      case 404:
        log('Not Found', name: 'API');
        return null;

      case 500:
        log('Internal Server Error', name: 'API');
        return null;

      default:
        log('Service Unavailable', name: 'API');
        return null;
    }
  }
}
