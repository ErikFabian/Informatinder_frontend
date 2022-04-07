import 'package:flutter/material.dart';
import 'package:frontend_flutter/main.dart';
import 'package:frontend_flutter/matchingPage.dart';
import 'package:frontend_flutter/matchesPage.dart';
import 'package:frontend_flutter/settingsPage.dart';

class bottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          switch (index) {
            case 1: //Matchen Page
              Navigator.pushReplacementNamed(context, matchingPage.routeName,
                  arguments: "");
              break;
            case 2: //Matchen Page
              Navigator.pushReplacementNamed(context, matchesPage.routeName,
                  arguments: "");
              break;
            case 3: //Matchen Page
              Navigator.pushReplacementNamed(context, settingsPage.routeName,
                  arguments: "");
              break;
            default: // Home Page
              Navigator.pushReplacementNamed(context, MyHomePage.routeName,
                  arguments: "");
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.touch_app),
            label: 'Matchen',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Matches',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          )
        ]);
  }
}
