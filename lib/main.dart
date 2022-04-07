import 'package:flutter/material.dart';
import 'package:frontend_flutter/matchingPage.dart';
import 'package:frontend_flutter/matchesPage.dart';
import 'package:frontend_flutter/settingsPage.dart';
import 'package:frontend_flutter/bottomNavBar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Routes
      routes: <String, WidgetBuilder>{
        MyHomePage.routeName: (context) => MyHomePage(),
        matchingPage.routeName: (context) => matchingPage(),
        matchesPage.routeName: (context) => matchesPage(),
        settingsPage.routeName: (context) => settingsPage(),
      },
      initialRoute: MyHomePage.routeName,

      onGenerateRoute: (RouteSettings settings) {
        var page;
        String routeName = settings.name.toString();
        switch (routeName) {
          case matchingPage.routeName:
            page = matchingPage(
              data: settings.arguments,
            );
            return MaterialPageRoute(builder: (context) => page);
        }
      },
      onUnknownRoute: (RouteSettings settings) {
        var page;
        page = MyHomePage();

        return MaterialPageRoute(builder: (context) => page);
      },

      title: 'Generated App',
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
  static const String routeName = "/";

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Name'),
      ),
      bottomNavigationBar: bottomNavBar(),
    );
  }
}
