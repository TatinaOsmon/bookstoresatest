import '/backend/schema/structs/index.dart';
import 'custom_auth_manager.dart';

export 'custom_auth_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _authManager = CustomAuthManager();
CustomAuthManager get authManager => _authManager;

String get currentUserUid => currentUser?.uid ?? '';
String? get currentAuthenticationToken => authManager.authenticationToken;
String? get currentAuthRefreshToken => authManager.refreshToken;
DateTime? get currentAuthTokenExpiration => authManager.tokenExpiration;
UserStruct? get currentUserData => currentUser?.userData;

class UserAuthStorage {
  // Колдонуучунун логин маалыматтарын сактоо
  Future<void> saveUserLogin(String username, String password) async {
    print("what is  $username");
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
