import 'package:shared_preferences/shared_preferences.dart';

class UserPrefers {
  String? _token;
  String? _role;
  int? _id;

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<int?> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('id');
  }

  Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');
  }

  Future<bool?> isLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') != null;
  }

  Future setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', token);
  }

  Future removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove('token');
  }

  Future setRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('role', role);
  }

  Future setId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt('id', id);
  }
}