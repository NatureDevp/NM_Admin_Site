import 'package:intl/intl.dart';

class Plants {
  Plants(
      {required this.id,
      required this.plant,
      required this.scientificName,
      required this.imageUrl,
      required this.likes,
      required this.description,
      required this.dateCreated,
      required this.lastUpdated});

  final int id;
  final String plant;
  final String scientificName;
  final String imageUrl;
  final String description;
  final int likes;
  final String dateCreated;
  final String lastUpdated;

  factory Plants.fromJson(Map<String, dynamic> json) {
    return Plants(
      id: json['id'],
      plant: _arrangeName(json['name']),
      scientificName: json['scientific'],
      imageUrl: json['image'],
      likes: json['likes'],
      description: json['description'],
      dateCreated: _parseToDate(json['created_at']),
      lastUpdated: _parseToDate(json['updated_at']),
    );
  }

  static String _parseToDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) {
      return 'None';
    }
    DateTime date = DateTime.parse(dateStr).toLocal();
    return DateFormat('MMMM d, yyyy at h:mm a').format(date);
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
