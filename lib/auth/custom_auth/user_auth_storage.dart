import 'package:shared_preferences/shared_preferences.dart';

class UserAuthStorage {
  // Колдонуучунун логин маалыматтарын сактоо
  Future<void> saveUserLogin(String username, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
  }

  // Колдонуучунун логин маалыматтарын алуу
  Future<Map<String, String>> getUserLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username') ?? '';
    String password = prefs.getString('password') ?? '';
    return {'username': username, 'password': password};
  }

  // Колдонуучунун логин маалыматтарын өчүрүү
  Future<void> clearUserLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('password');
  }
}
