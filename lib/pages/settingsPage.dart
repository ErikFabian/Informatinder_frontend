import 'package:flutter/material.dart';

class settingsPage extends StatefulWidget {
  const settingsPage({Key? key}) : super(key: key);
  settingsPageState createState() => settingsPageState();
}

class settingsPageState extends State<settingsPage> {
  bool _notifications = true;
  bool _gps = true;
  String _radius = "30 KM";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
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
                      value: _notifications,
                      onChanged: (value) {
                        setState(() {
                          _notifications = value!;
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
                      value: _gps,
                      onChanged: (value) {
                        setState(() {
                          _gps = value!;
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
                      value: _radius,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Radius',
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _radius = newValue!;
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
                              Navigator.of(context)
                                  .pushReplacementNamed('/login');
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
                              Navigator.of(context)
                                  .pushReplacementNamed('/login');
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
    ));
  }
}
