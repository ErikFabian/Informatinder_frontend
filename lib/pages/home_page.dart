import 'package:flutter/material.dart';
import 'package:frontend_flutter/controller/network_controller.dart';
import 'package:frontend_flutter/views/editable_profile.dart';
import 'package:frontend_flutter/models/profile.dart';
import 'package:frontend_flutter/views/profile_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  ImagePicker picker = ImagePicker();
  Profile profile = Profile(id: 0, isBetrieb: false);

// FLAG IF PROFILE IS EDITABLE AT THE MOMENT
  bool editable = false;

  _changeEditableState() {
    if (editable) {
      NetworkController.updateProfile(profile);
    }
    setState(() {
      editable = !editable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Profile>(
        future: NetworkController.getProfile(),
        builder: (BuildContext context, AsyncSnapshot<Profile> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('Loading'));
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              profile = snapshot.data!;

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

                                NetworkController.uploadImage(
                                    File(image!.path));
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
                            onPressed: (() => _changeEditableState()),
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
