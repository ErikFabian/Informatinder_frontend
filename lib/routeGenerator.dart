import 'package:flutter/material.dart';
import 'package:frontend_flutter/main.dart';
import 'package:frontend_flutter/matchesPage.dart';
import 'package:frontend_flutter/matchingPage.dart';
import 'package:frontend_flutter/registerPage.dart';
import 'package:frontend_flutter/settingsPage.dart';
import 'package:frontend_flutter/loginPage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MyHomePage());
      case '/matching':
        return MaterialPageRoute(builder: (_) => matchingPage());
      case '/matches':
        return MaterialPageRoute(builder: (_) => matchesPage());
      case '/settings':
        return MaterialPageRoute(builder: (_) => settingsPage());
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
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
