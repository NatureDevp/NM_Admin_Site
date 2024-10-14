import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveSessionToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('auth_token', token);
}

Future<String?> getSessionToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString('auth_token');
}

//
Future<void> deleteSessionToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('auth_token');
}

//
Future<bool> hasSessionToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.containsKey('auth_token');
}
