import 'package:intl/intl.dart';

class RequestPlant {
  RequestPlant({
    required this.id,
    required this.user_id,
    required this.plant_name,
    required this.scientific_name,
    required this.description,
    required this.image_url,
    required this.handle_by,
    required this.status,
    required this.last_updated,
    required this.date_created,
  });

  final int id;
  final int user_id;
  final String plant_name;
  final String scientific_name;
  final String description;
  final String image_url;
  final int handle_by;
  final String status;
  final String last_updated;
  final String date_created;

  // Factory method to create an instance from JSON
  factory RequestPlant.fromJson(Map<String, dynamic> json) {
    return RequestPlant(
      id: json['id'] as int,
      user_id: json['user_id'] as int,
      plant_name: _arrangeName(json['plant_name'] as String?),
      scientific_name: _arrangeName(json['scientific'] as String?),
      description: json['description'] as String,
      image_url: json['image_path'] as String,
      handle_by: json['handle_by'] as int,
      status: json['status'] as String,
      last_updated: _parseToDate(json['updated_at'] as String?),
      date_created: _parseToDate(json['created_at'] as String?),
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'plant_name': plant_name,
      'scientific': scientific_name,
      'description': description,
      'image_path': image_url,
      'handle_by': handle_by,
      'status': status,
    };
  }

  static String _parseToDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) {
      return 'None';
    }
    try {
      DateTime date = DateTime.parse(dateStr).toLocal();
      return DateFormat('MMMM d, yyyy at h:mm a').format(date);
    } catch (e) {
      return 'Invalid Date';
    }
  }

  static String _arrangeName(String? str) {
    if (str == null || str.isEmpty) {
      return 'Unknown';
    }
    return str.trim().split(' ').map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      }
      return word;
    }).join(' ');
  }
}
