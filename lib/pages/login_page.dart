import 'package:flutter/material.dart';
import 'package:frontend_flutter/controller/network_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: const Text("Login"), automaticallyImplyLeading: false),
        body: SingleChildScrollView(
            child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
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
                        NetworkController.login(email, password)
                            .then((value) => {
                                  if (value)
                                    {
                                      Navigator.of(context)
                                          .popUntil((route) => route.isFirst),
                                      Navigator.of(context)
                                          .pushReplacementNamed('/')
                                    }
                                  else
                                    {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Wrong Password or Email")))
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
        )));
  }
}
