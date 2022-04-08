import 'package:flutter/material.dart';
import 'package:frontend_flutter/bottomNavBar.dart';

class settingsPage extends StatelessWidget {
  static const String routeName = "/settingsPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Column(
        children: [
          Image.asset(
            'images/example.png',
            width: 500,
            height: 100,
            fit: BoxFit.cover,
          ),
        ],
      ),
      bottomNavigationBar: bottomNavBar(),
    );
  }
}
