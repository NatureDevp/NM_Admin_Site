class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.token,
    required this.dateCreated,
    required this.lastUpdated,
  });

  final String id;
  final String name;
  final String email;
  final String password;
  final String token;
  final String dateCreated;
  final String lastUpdated;
}

class UserColumn {
  UserColumn({
    required this.id,
    required this.name,
    required this.email,
    required this.dateCreated,
    required this.lastUpdated,
  });

  final String id;
  final String name;
  final String email;
  final String dateCreated;
  final String lastUpdated;
}
