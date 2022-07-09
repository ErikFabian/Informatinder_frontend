import 'package:flutter/material.dart';
import 'package:frontend_flutter/main.dart';
import 'package:frontend_flutter/pages/registerPage.dart';
import 'package:frontend_flutter/pages/loginPage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MyHomePage());
      case '/login':
        return MaterialPageRoute(builder: (_) => loginPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => registerPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
