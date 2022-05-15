import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/profile.dart';
import 'package:frontend_flutter/profilePage.dart';
import 'package:frontend_flutter/userPreferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class matchesPage extends StatelessWidget {
  Future<List<Profile>> getMatches() async {
    String? token = await UserPreferences().getToken();

    final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/matches' + token.toString()),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData['profiles'];
    } else {
      throw Exception("No Matches found");
    }
  }

  Widget matchesSection(
      String profileName, int profileID, BuildContext context) {
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
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => profilePage(
                            key: key!,
                            profileID: profileID,
                          ),
                        ),
                      );
                    },
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
    return ListView(
      children: <Widget>[
        for (int i = 0; i <= 15; i++)
          matchesSection("name" + i.toString(), i, context),
      ],
    );
  }
}
