import 'package:flutter/material.dart';
import 'package:frontend_flutter/bottomNavBar.dart';

class settingsPage extends StatelessWidget {
  static const String routeName = "/settingsPage";

  final data;
  settingsPage({this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("settingsPage"),
      ),
      bottomNavigationBar: bottomNavBar(),
    );
  }
}
