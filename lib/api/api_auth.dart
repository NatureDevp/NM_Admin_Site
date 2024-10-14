import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import '../models/md_auth.dart';
import 'api_status_code.dart';
import 'api_url.dart';
import 'package:http/http.dart' as http;

class APIAuth {
  //

  static Future<Map<String, dynamic>?> checkLoginStatus(String token) async {
    //
    final url = Uri.parse('${BASE_URL}api/auth/session');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true',
          'Authorization': 'Bearer $token',
        },
      );

      return await validateStatus(response);
    } catch (e) {
      log('CLIENT ERROR', name: 'API AUTH', error: e);
      return null;
    }
  }

  static Future<Map<String, dynamic>?> register(
      Authorization credentials) async {
    //
    final url = Uri.parse('${BASE_URL}api/auth/register');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true',
        },
        body: json.encode(credentials.toJson()),
      );

      return await validateStatus(response);

      //
    } catch (e) {
      log('CLIENT ERROR', name: 'API AUTH', error: e);
      return null;
    }
  }

//
  static Future<Map<String, dynamic>?> login(Authorization credentials) async {
    final url = Uri.parse('${BASE_URL}api/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true',
        },
        body: json.encode(credentials.toJson()),
      );

      return validateStatus(response);

      //
    } catch (e) {
      log('CLIENT ERROR', name: 'API AUTH', error: e);
      return null;
    }
  }
}
