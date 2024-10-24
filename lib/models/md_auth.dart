import 'dart:math';

class Authorization {
  String? firstName;
  String? lastName;
  String email;
  String? password;
  String? passwordConfirmation;
  String role = 'Admin';
  String? accessToken;

  Authorization({
    this.firstName,
    this.lastName,
    required this.email,
    this.password,
    this.role = 'Admin',
    this.passwordConfirmation,
    this.accessToken,
  });

  Map<String, dynamic> toJson() => {
        'name': formatName(
          firstName ?? 'User',
          lastName ?? '${Random().nextInt(999)}',
        ),
        'email': formatEmail(email),
        'role': 'Admin',
        'password': password,
        'password_confirmation': passwordConfirmation,
      };

  factory Authorization.fromJson(Map<String, dynamic> json, String? token) {
    String fname = json['name'].toString().split(' ').first;
    String lname = json['name'].toString().split(' ').last;

    //
    return Authorization(
      firstName: fname,
      lastName: lname,
      email: json['email'],
      role: json['role'],
      accessToken: token,
    );
  }

  String formatName(String firstName, String lastName) {
    // Capitalizes the first letter of each part of the name
    return '${capitalize(firstName)} ${capitalize(lastName)}';
  }

  String formatEmail(String email) {
    // Converts the email to lowercase
    return email.toLowerCase();
  }

  String capitalize(String text) {
    // Capitalizes the first letter of a string
    if (text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}
