import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import '../utils/_local_storage.dart';
import 'api_status_code.dart';
import 'api_url.dart';
import 'package:http/http.dart' as http;

class APIPlant {
  static Future<Map<String, dynamic>?> fetchPlants() async {
    //

    final url = Uri.parse('${BASE_URL}api/v1/plants');
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

  Stream<List<dynamic>> fetchPlantsStream() async* {
    final url = Uri.parse(
        'http://your_api_endpoint_here'); // Replace with your API endpoint
    final request = http.Request('GET', url);

    // Send the request and get a streamed response
    final streamedResponse = await request.send();

    if (streamedResponse.statusCode == 200) {
      List<dynamic> plants = [];

      // Stream data by parsing each chunk of the streamed response
      await for (var chunk in streamedResponse.stream.transform(utf8.decoder)) {
        try {
          // Parse each chunk and add to the list of plants
          final decodedData = json.decode(chunk);

          if (decodedData is List) {
            plants.addAll(
                decodedData); // If the response is a list, add all items
          } else {
            plants.add(decodedData); // Otherwise, add the item directly
          }

          yield plants; // Emit the updated list to refresh the UI
        } catch (e) {
          print('Error parsing chunk: $e');
        }
      }
    } else {
      throw Exception(
          'Failed to load data with status: ${streamedResponse.statusCode}');
    }
  }
}
