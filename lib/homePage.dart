import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/profile.dart';
import 'package:frontend_flutter/userPreferences.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);
  homePageState createState() => homePageState();
}

class homePageState extends State<homePage> {
  static const String routeName = "/matchesPage";

  //TODO: Hier Text aus der DB holen und in profileText abspeichern
  final TextEditingController _profileTextController =
      TextEditingController(text: "Test");
  final TextEditingController _nameTextController =
      TextEditingController(text: "*Name*");

  bool editable = false;
  Color editableButtonColor = Colors.transparent;

  Future<Profile> getProfile() async {
    String? id = await UserPreferences().getId();

    final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/profile/' + id.toString()),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData['profile'];
    } else {
      throw Exception("No Profile found");
    }
  }

  Future<Profile> updateProfile() async {
    String? id = await UserPreferences().getId();

    final response = await http.patch(
        Uri.parse('http://10.0.2.2:8080/profile/' + id.toString()),
        body: {});

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData['profile'];
    } else {
      throw Exception("No Profile found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: _nameTextController,
                              enabled: editable,
                              maxLines: null,
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
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
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: editableButtonColor,
                        child: IconButton(
                          icon: const Icon(
                            Icons.edit_outlined,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            if (editable) {
                              editableButtonColor = Colors.transparent;
                              //TODO: Hier Text absenden der in der _profileTextController.text steht
                            } else {
                              editableButtonColor = Colors.blue;
                            }
                            setState(() {
                              editable = !editable;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: TextFormField(
                    controller: _profileTextController,
                    enabled: editable,
                    maxLines: null,
                    style: const TextStyle(fontSize: 14),
                  ),
                )
              ],
            )));
  }
}
