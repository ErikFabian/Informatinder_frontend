import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_flutter/EditableProfile.dart';
import 'package:frontend_flutter/models/profile.dart';
import 'package:frontend_flutter/profile_builder.dart';
import 'package:frontend_flutter/userPreferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import 'package:http/http.dart' as http;
import 'package:async/async.dart';
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

  ImagePicker picker = ImagePicker();

  Profile profile = Profile(id: 0, isBetrieb: false);
  bool editable = false;
  Color editableButtonColor = Colors.transparent;

  uploadImage(File imageFile) async {
    String? token = await UserPreferences().getToken();
    Map<String, String> headers = {
      'x-access-token': token!,
    };
    var stream = http.ByteStream(DelegatingStream(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse("http://h2973117.stratoserver.net:8080/profile/image/");
    var request = http.MultipartRequest("POST", uri);
    request.headers.addAll(headers);
    var multipartFile = http.MultipartFile('image', stream, length,
        filename: basename(imageFile.path));

    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode != 200) {
      throw Exception("Image upload failed");
    }
  }

  Future<Profile> getProfile() async {
    String? id = await UserPreferences().getId();

    final response = await http.get(
      Uri.parse(
          'http://h2973117.stratoserver.net:8080/profile/' + id.toString()),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      profile = Profile.fromJson(responseData['profile']);
      return profile;
    } else {
      throw Exception("No Profile found");
    }
  }

  Future<Profile> updateProfile(Profile profile) async {
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
          'image': profile.image ??= "",
          'name': profile.name ??= "",
          'website': profile.website ??= "",
          'experience':
              profile.experience == null ? "" : profile.experience.toString(),
          'location': profile.location ??= "",
          'benefits': profile.benefits.toString(),
          'categories': profile.benefits.toString(),
          'languages': profile.languages.toString(),
          'description': profile.description ??= "",
          'isBetrieb': profile.isBetrieb.toString()
        }));

    if (response.statusCode != 200) {
      return profile;
    } else if (response.statusCode == 404) {
      throw Exception("No Profile found");
    } else {
      throw Exception("SERVER ERROR");
    }
  }

  _changeEditableState() {
    setState(() {
      editable = !editable;
    });
  }

  _changeEditableStateAndUpdate() {
    updateProfile(profile);
    setState(() {
      editable = !editable;
    });
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
              profile = snapshot.data!;
              if (!editable) {
                _profileNameController.text = profile.name!;
                _profileTextController.text = profile.description!;
              }

              return SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Column(
                        children: [
                          InkWell(
                            child: Image.network(
                              'http://h2973117.stratoserver.net:8080' +
                                  profile.image!,
                              width: 600,
                              height: 300,
                              fit: BoxFit.cover,
                            ),
                            onTap: () async {
                              if (editable) {
                                XFile? image = await picker.pickImage(
                                    source: ImageSource.gallery);

                                uploadImage(File(image!.path));
                              }
                            },
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                top: 32, left: 32, right: 32),
                            child: editable
                                ? EditableProfile(data: profile)
                                : ProfileBuilder.buildProfile(profile),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                primary: Colors.white),
                            onPressed: (() => editable
                                ? _changeEditableStateAndUpdate()
                                : _changeEditableState()),
                            child: Text(
                              editable ? "SAVE" : "EDIT",
                            ),
                          ),
                        ],
                      )));
            }
          }
        });
  }
}
