import 'package:flutter/material.dart';
import 'package:frontend_flutter/bottomNavBar.dart';

class matchingPage extends StatelessWidget {
  static const String routeName = "/matchingPage";

  final data;
  matchingPage({this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("matchingPage"),
      ),
      bottomNavigationBar: bottomNavBar(),
    );
  }
}
