import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  final TextEditingController _profileTextController = TextEditingController();
  final TextEditingController _profileNameController = TextEditingController();

  bool editable = false;
  Color editableButtonColor = Colors.transparent;

  Future<Profile> getProfile() async {
    String? id = await UserPreferences().getId();

    final response = await http.get(
      Uri.parse(
          'http://h2973117.stratoserver.net:8080/profile/' + id.toString()),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      return Profile.fromJson(responseData['profile']);
    } else {
      throw Exception("No Profile found");
    }
  }

  void updateProfile(String name, String description, bool isBetrieb) async {
    String? id = await UserPreferences().getId();
    String? token = await UserPreferences().getToken();

    final response = await http.patch(
        Uri.parse(
            'http://h2973117.stratoserver.net:8080/profile/' + id.toString()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-access-token': token!,
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'description': description,
          'isBetrieb': isBetrieb.toString()
        }));

    if (response.statusCode != 200) {
      throw Exception("No Profile found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Profile>(
        future: getProfile(),
        builder: (BuildContext context, AsyncSnapshot<Profile> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('Loading'));
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              Profile profile = snapshot.data!;
              if (!editable) {
                _profileNameController.text = profile.name;
                _profileTextController.text = profile.description;
              }

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
                            padding: const EdgeInsets.only(
                                top: 32, left: 32, right: 32),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextFormField(
                                        controller: _profileNameController,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(50),
                                        ],
                                        enabled: editable,
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
                                        editableButtonColor =
                                            Colors.transparent;
                                        updateProfile(
                                            _profileNameController.text,
                                            _profileTextController.text,
                                            false);
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
        });
  }
}
