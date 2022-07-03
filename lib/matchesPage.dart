import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/language.dart';
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
      Uri.parse('http://h2973117.stratoserver.net:8080/matches'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-access-token': token!,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      List iterProfiles = responseData['profiles'];
      List<Profile> profiles = [];

      for (int i = 0; i < iterProfiles.length; i++) {
        Profile tempProfile = Profile.fromJson(iterProfiles[i]['profile']);

        List iterLanguages = iterProfiles[i]['languages'];
        tempProfile.languages = List<Language>.from(
            iterLanguages.map((element) => Language.fromJson(element)));

        List iterBenefits = iterProfiles[i]['benefits'];
        tempProfile.benefits = List<String>.from(
            iterBenefits.map((element) => element.toString()));

        List iterCategories = iterProfiles[i]['categories'];
        tempProfile.categories = List<String>.from(
            iterCategories.map((element) => element.toString()));

        profiles.add(tempProfile);
      }
      return profiles;
    } else {
      throw Exception("No Profiles found");
    }
  }

  Widget matchesSection(Profile profile, BuildContext context) {
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
                    Text(
                      profile.name!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30),
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
                            key: key,
                            profile: profile,
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
    return FutureBuilder<List<Profile>>(
        future: getMatches(),
        builder: (BuildContext context, AsyncSnapshot<List<Profile>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('Loading'));
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<Profile> profiles = snapshot.data!;
              return ListView(
                children: <Widget>[
                  for (int i = 0; i < profiles.length; i++)
                    matchesSection(profiles[i], context),
                ],
              );
            }
          }
        });
  }
}
