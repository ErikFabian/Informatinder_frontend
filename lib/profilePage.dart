import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'models/profile.dart';

Future<Profile> getProfile(int id) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:8080/profile/' + id.toString()),
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

  final TextEditingController _profileTextController = TextEditingController();
  final TextEditingController _profileNameController = TextEditingController();

  profilePage({required Key key, required this.profileID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Profile>(
        future: getProfile(profileID),
        builder: (BuildContext context, AsyncSnapshot<Profile> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('Loading'));
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              Profile profile = snapshot.data!;
              _profileNameController.text = profile.name;
              _profileTextController.text = profile.description;

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
                                  controller: _profileTextController,
                                  enabled: false,
                                  maxLines: null,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              )
                            ],
                          ))));
            }
          }
        });
  }
}
