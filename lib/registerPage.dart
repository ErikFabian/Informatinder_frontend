import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class registerPage extends StatefulWidget {
  regPage createState() => regPage();
}

class regPage extends State<registerPage> {
  bool company = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Future<bool> register(String email, String username, String password,
      String confirmPassword) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/user/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'username': username,
        'password': password,
        'repeatPassword': confirmPassword
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      // UserPreferences().saveUser();

      return true;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to register.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Column(
        children: [
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
                          controller: _emailController,
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
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: const Text(
                          'Confirm Password',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 16),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: const Text(
                          'Name',
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
                          'Geburtdatum',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 16),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                        ),
                      ),
                      CheckboxListTile(
                        title: const Text("Company"),
                        value: company,
                        onChanged: (value) {
                          setState(() {
                            company = value!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      Container(
                          child: Padding(
                        padding:
                            const EdgeInsets.only(top: 32, left: 32, right: 32),
                        child: ElevatedButton(
                          onPressed: () {
                            String email = _emailController.text;
                            String username = _usernameController.text;
                            String password = _passwordController.text;
                            String confirmPassword =
                                _confirmPasswordController.text;

                            register(email, username, password, confirmPassword)
                                .then((value) => {
                                      if (value)
                                        {
                                          {
                                            Navigator.of(context)
                                                .pushReplacementNamed('/login')
                                          }
                                        }
                                    });

                            Navigator.of(context)
                                .pushNamedAndRemoveUntil('/', (r) => false);
                          },
                          child: const Text('Register'),
                        ),
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
