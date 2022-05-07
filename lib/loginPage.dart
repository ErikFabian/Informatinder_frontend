import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/User.dart';
import 'package:frontend_flutter/userPreferences.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class loginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/user/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      User user = User.fromJson(responseData);

      UserPreferences().saveUser(user);

      return true;
    } else {
      throw Exception('Failed to login.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: const Text("Login"), automaticallyImplyLeading: false),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'images/logo.png',
                width: 500,
                height: 100,
                fit: BoxFit.cover,
              ),
              Container(
                padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: const Text(
                              'E-Mail',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 16),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: TextFormField(
                              controller: _usernameController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: const Text(
                              'Password',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 16),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: TextFormField(
                              controller: _passwordController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 32, left: 32, right: 32),
                    child: ElevatedButton(
                      onPressed: () {
                        String email = _usernameController.text;
                        String password = _passwordController.text;

                        login(email, password).then((value) => {
                              if (value)
                                {
                                  Navigator.of(context)
                                      .pushReplacementNamed('/')
                                }
                              else
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("Wrong Password or Email")))
                                }
                            });
                      },
                      child: const Text('Login'),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 32, left: 32, right: 32),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/register');
                      },
                      child: const Text('Register'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
