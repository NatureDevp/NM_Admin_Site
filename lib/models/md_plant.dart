import 'dart:typed_data';

import 'package:intl/intl.dart';

class Plants {
  Plants({
    required this.id,
    required this.name,
    required this.scientific_name,
    required this.cover,
    required this.likes,
    required this.status,
    required this.description,
    required this.ailment,
    required this.date_created,
    required this.last_updated,
  });

  final int id;
  final String name;
  final String scientific_name;
  final String cover;
  final String description;
  final int likes;
  final String status;
  final List<String> ailment;
  final String date_created;
  final String last_updated;

  factory Plants.fromJson(Map<String, dynamic> json) {
    return Plants(
      id: json['id'],
      name: _arrangeName(json['name']),
      scientific_name: json['scientific'],
      cover: json['cover'],
      likes: json['like'],
      status: json['status'],
      ailment: json['ailment'].toString().split(','),
      description: json['description'],
      date_created: _parseToDate(json['created_at']),
      last_updated: _parseToDate(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['scientific'] = scientific_name;
    data['status'] = status;
    data['ailment'] = ailment.join(',');
    data['description'] = description;
    data['created_at'] = date_created;
    data['updated_at'] = last_updated;
    return data;
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
