class Request {
  Request({
    required this.id,
    required this.plant,
    required this.imageUrl,
    required this.requestDate,
    required this.status,
    required this.lastUpdated,
  });

  final String id;
  final String plant;
  final String requestDate;
  final String imageUrl;
  final String status;
  final String lastUpdated;
}

class RequestColumn {
  RequestColumn({
    required this.id,
    required this.plant,
    required this.imageUrl,
    required this.requestDate,
    required this.status,
    required this.lastUpdated,
  });

  final String id;
  final String plant;
  final String requestDate;
  final String imageUrl;
  final String status;
  final String lastUpdated;
}
