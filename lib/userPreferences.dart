import 'package:frontend_flutter/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("email", user.email);
    prefs.setString("password", user.password);
    prefs.setString("token", user.token);

    return true;
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? email = prefs.getString("email");
    String? password = prefs.getString("password");
    String? token = prefs.getString("token");

    return User(email: email!, password: password!, token: token!);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("email");
    prefs.remove("password");
    prefs.remove("token");
  }

  Future<String?> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    return token;
  }
}
