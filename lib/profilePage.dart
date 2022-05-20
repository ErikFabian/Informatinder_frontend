import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'models/profile.dart';

Future<Profile> getProfile(int id) async {
  final response = await http.post(
    Uri.parse('http://h2973117.stratoserver.net:8080/profile/' + id.toString()),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> responseData = json.decode(response.body);
    Profile profile = Profile.fromJson(responseData);
    return profile;
  } else {
    throw Exception("No Profile found");
  }
}

class profilePage extends StatelessWidget {
  final int profileID;
  final String profileName;
  final String profileDescription;
  final bool isBetrieb;

  const profilePage(
      {Key? key,
      required this.profileID,
      required this.profileName,
      required this.profileDescription,
      required this.isBetrieb})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text("InformaTinder")),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  children: [
                    Image.asset(
                      'images/teacher_female.png',
                      width: 600,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(top: 32, left: 32, right: 32),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  initialValue: profileName,
                                  enabled: false,
                                  maxLines: null,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
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
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(32),
                      child: TextFormField(
                        initialValue: profileDescription,
                        enabled: false,
                        maxLines: null,
                        style: const TextStyle(fontSize: 14),
                      ),
                    )
                  ],
                ))));
  }
}
