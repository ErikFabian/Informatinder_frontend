import 'package:flutter/material.dart';
import 'package:frontend_flutter/bottomNavBar.dart';

class settingsPage extends StatefulWidget {
  static const String routeName = "/settingsPage";
  settingPage createState() => settingPage();
}

class settingPage extends State<settingsPage> {
  bool notifications = true;
  bool gps = true;
  String dropdownValue = "30 KM";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: Column(
          children: [
            Image.asset(
              'images/logo.png',
              width: 500,
              height: 100,
              fit: BoxFit.cover,
            ),
            Container(
              padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: const Text(
                            'App',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        ),
                        CheckboxListTile(
                          title: const Text("Notifications"),
                          value: notifications,
                          onChanged: (value) {
                            setState(() {
                              notifications = value!;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: const Text(
                            'Suche',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        ),
                        CheckboxListTile(
                          title: const Text("Use GPS"),
                          value: gps,
                          onChanged: (value) {
                            setState(() {
                              gps = value!;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: TextFormField(
                            decoration: const InputDecoration(
                                labelText: "Set Custom Location",
                                border: InputBorder.none),
                          ),
                        ),
                        DropdownButtonFormField<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Radius',
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: <String>[
                            '5 KM',
                            '10 KM',
                            '15 KM',
                            '20 KM',
                            '30 KM',
                            '50 KM',
                            '100 KM',
                            '200 KM',
                            '500 KM',
                            '1000 KM'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 32, left: 32, right: 32),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/login');
                                },
                                child: const Text('Log out'),
                              ),
                            )),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 32, left: 32, right: 32),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/register');
                                },
                                child: const Text('Delete Account'),
                              ),
                            )),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.blue,
            currentIndex: 3,
            onTap: (index) {
              if (3 != index.toInt()) {
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
            ]));
  }
}
