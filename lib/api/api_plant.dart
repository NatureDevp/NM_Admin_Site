import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:admin_new/models/md_plant.dart';

import '../utils/_local_storage.dart';
import 'api_status_code.dart';
import 'api_url.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

class APIPlant {
  static Future<Map<String, dynamic>?> fetchPlants() async {
    //

    final url = Uri.parse('${BASE_URL}api/v2/plants');
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

// Assuming your Plants class has a property for the image file
  static Future<Map<String, dynamic>?> uploadPlants(
    Plants plant,
    Map<String, html.File> cover,
    List<Map<String, html.File>> images,
  ) async {
    final url = Uri.parse('${BASE_URL}api/v2/plants');
    String accessToken = await getSessionToken() ?? '';

    try {
      // Prepare multipart request
      var request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $accessToken';
      request.headers['Content-Type'] = 'multipart/form-data';
      request.headers['Accept'] = 'application/json';
      request.headers['ngrok-skip-browser-warning'] = 'true';

      // Add plant data as fields
      request.fields['name'] = plant.name;
      request.fields['scientific'] = plant.scientific_name;
      request.fields['description'] = plant.description;
      request.fields['status'] = plant.status;
      request.fields['ailment'] = plant.ailment.join(',');

      final reader = html.FileReader();
      reader.readAsArrayBuffer(cover.values.first);
      await reader.onLoad.first;

      final data = reader.result as Uint8List;
      request.files.add(
        http.MultipartFile.fromBytes(
          'cover',
          data,
          filename: cover.values.first.name,
        ),
      );

      
      // request.files.addAll(
      //   images.map((image) {
      //     final reader = html.FileReader();
      //     Uint8List data = Uint8List(0);
      //     reader.readAsArrayBuffer(image.values.first);
      //     reader.onLoad.first.then((await) {
      //       data = reader.result as Uint8List;
      //     });

          return http.MultipartFile.fromBytes(
            'images[]',
            data,
            filename: image.values.first.name,
          );
        }),
      )

      String responseData = '';
      final response = await request.send();
      response.stream.listen((data) {
        responseData = utf8.decode(data);
      });

      return await validateStatus(json.decode(responseData));
    } catch (e) {
      log(': CLIENT ERROR', name: 'API', error: e);
      return null;
    }
  }
}
