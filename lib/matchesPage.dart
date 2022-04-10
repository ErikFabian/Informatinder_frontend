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
        bottomNavigationBar: bottomNavBar(),
        body: ListView(
          children: <Widget>[
            for (int i = 0; i <= 15; i++)
              matchesSection("name" + i.toString(), ""),
          ],
        ));
  }
}
