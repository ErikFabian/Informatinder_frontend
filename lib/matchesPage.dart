import 'package:flutter/material.dart';
import 'package:frontend_flutter/bottomNavBar.dart';

class matchesPage extends StatelessWidget {
  static const String routeName = "/matchesPage";

  Widget matchesSection(String profileName, String profile) {
    return Column(children: [
      Container(
        margin: const EdgeInsets.only(left: 8, right: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.black),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        profileName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                    ),
                  ]),
            ),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Profil'),
                  )
                ]))
          ],
        ),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Matches"),
        ),
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.blue,
            currentIndex: 2,
            onTap: (index) {
              if (2 != index.toInt()) {
                switch (index.toInt()) {
                  case 0:
                    Navigator.of(context).pushNamed('/');
                    break;
                  case 1:
                    Navigator.of(context).pushNamed('/matching');
                    break;
                  case 2:
                    Navigator.of(context).pushNamed('/matches');
                    break;
                  case 3:
                    Navigator.of(context).pushNamed('/settings');
                    break;
                }
              }
            },
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
            ]),
        body: ListView(
          children: <Widget>[
            for (int i = 0; i <= 15; i++)
              matchesSection("name" + i.toString(), ""),
          ],
        ));
  }
}
