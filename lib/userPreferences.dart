import 'package:frontend_flutter/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("id", user.id.toString());
    prefs.setString("username", user.username);
    prefs.setString("email", user.email);
    prefs.setString("token", user.token);

    return true;
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? id_string = prefs.getString("id");
    int id = 0;
    String? username = prefs.getString("username");
    String? email = prefs.getString("email");
    String? token = prefs.getString("token");

    if (id_string != null) {
      id = int.parse(id_string);
    }

    return User(id: id, username: username!, email: email!, token: token!);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("id");
    prefs.remove("username");
    prefs.remove("email");
    prefs.remove("token");
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    return token;
  }

  Future<int> getId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getString("id") as int;
    return id;
  }
}
