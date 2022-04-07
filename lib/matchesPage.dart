import 'package:flutter/material.dart';
import 'package:frontend_flutter/bottomNavBar.dart';

class matchesPage extends StatelessWidget {
  static const String routeName = "/matchesPage";

  final data;
  matchesPage({this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("matchesPage"),
      ),
      bottomNavigationBar: bottomNavBar(),
    );
  }
}
