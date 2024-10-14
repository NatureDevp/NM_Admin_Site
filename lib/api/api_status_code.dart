import 'dart:developer';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> validateStatus(http.Response response) async {
  switch (response.statusCode) {
    case 200:
      log(
        json.decode(response.body)['message'],
        name: 'API ${response.statusCode}:',
      );
      return json.decode(response.body);

    case 201:
      log(
        json.decode(response.body)['message'],
        name: 'API ${response.statusCode}:',
      );
      return json.decode(response.body);

    case 204:
      log(
        json.decode(response.body)['message'],
        name: 'API ${response.statusCode}:',
      );
      return null;

    case 400:
      log(
        json.decode(response.body)['message'],
        name: 'API ${response.statusCode}:',
      );
      return null;

    case 401:
      log(
        json.decode(response.body)['message'],
        name: 'API ${response.statusCode}:',
      );
      return {
        'status': false,
        'message': json.decode(response.body)['message'],
      };

    case 404:
      log(
        json.decode(response.body)['message'],
        name: 'API ${response.statusCode}',
      );
      return null;

    case 422:
      log(
        json.decode(response.body)['message'],
        name: 'API ${response.statusCode}',
      );
      return json.decode(response.body);

    case 500:
      log(
        json.decode(response.body)['message'],
        name: 'API ${response.statusCode}',
      );
      return null;

    default:
      log('Service Unavailable', name: 'API', error: response.statusCode);
      return null;
  }
}
