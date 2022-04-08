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
  static const String routeName = "/";

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    '*Name*',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                Text(
                  'Betrieb/Bewerber',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          Icon(
            Icons.edit_outlined,
          ),
        ],
      ),
    );

    Widget textSection = const Padding(
      padding: EdgeInsets.all(32),
      child: Text(
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna ut labore et dolore magna  At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut',
        softWrap: true,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          Image.asset(
            'images/example.png',
            width: 600,
            height: 240,
            fit: BoxFit.cover,
          ),
          titleSection,
          textSection,
        ],
      ),
      bottomNavigationBar: bottomNavBar(),
    );
  }
}
