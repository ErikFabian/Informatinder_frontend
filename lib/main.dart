import 'package:flutter/material.dart';
import 'package:frontend_flutter/homePage.dart';
import 'package:frontend_flutter/loginPage.dart';
import 'package:frontend_flutter/matchingPage.dart';
import 'package:frontend_flutter/matchesPage.dart';
import 'package:frontend_flutter/settingsPage.dart';
import 'package:frontend_flutter/routeGenerator.dart';

void main() {
  runApp(MyApp());
}

final key = new GlobalKey<settingsPageState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      onGenerateRoute: RouteGenerator.generateRoute,
      title: 'Informatinder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int page = 0;

  Widget bodyFunction() {
    switch (page) {
      case 0:
        return homePage();
      case 1:
        return matchingPage();
      case 2:
        return matchesPage();
      default:
        return settingsPage(
          key: key,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("InformaTinder"),
      ),
      body: bodyFunction(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: page,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.touch_app),
              label: 'Matchen',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Matches',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
              backgroundColor: Colors.black)
        ],
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
      ),
    );
  }
}
