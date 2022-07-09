import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/language.dart';
import 'package:frontend_flutter/views/profile_builder.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:frontend_flutter/models/profile.dart';
import 'package:frontend_flutter/controller/user_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class MatchingPage extends StatefulWidget {
  const MatchingPage({Key? key}) : super(key: key);

  @override
  MatchingPageState createState() => MatchingPageState();
}

class MatchingPageState extends State<MatchingPage> {
  late MatchEngine _matchEngine;
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  int thisPage = 1;

  Future<List<Profile>> getProfile(int page) async {
    String? token = await UserPreferences().getToken();
    thisPage++;

    final response = await http.get(
        Uri.parse('http://h2973117.stratoserver.net:8080/swipe/' +
            page.toString() +
            "/5"),
        headers: <String, String>{
          'x-access-token': token!,
        });

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

  void sendLike(int id) async {
    String? token = await UserPreferences().getToken();

    final response = await http.post(
        Uri.parse('http://h2973117.stratoserver.net:8080/matches/like/' +
            id.toString()),
        headers: <String, String>{
          'x-access-token': token!,
        });
    if (response.statusCode != 200) {
      throw Exception("Like not send");
    }
  }

  void sendDislike(int id) async {
    String? token = await UserPreferences().getToken();

    final response = await http.post(
        Uri.parse('http://h2973117.stratoserver.net:8080/matches/dislike/' +
            id.toString()),
        headers: <String, String>{
          'x-access-token': token!,
        });
    if (response.statusCode != 200) {
      throw Exception("Dislike not send");
    }
  }

  void initSwipeState(BuildContext context, List<Profile> inputProfiles) {
    _swipeItems.clear();
    for (int i = 0; i < inputProfiles.length; i++) {
      _swipeItems.add(SwipeItem(
        content: Profile(
            id: inputProfiles[i].id,
            name: inputProfiles[i].name,
            description: inputProfiles[i].description,
            isBetrieb: inputProfiles[i].isBetrieb,
            location: inputProfiles[i].location,
            website: inputProfiles[i].website,
            benefits: inputProfiles[i].benefits,
            categories: inputProfiles[i].categories,
            languages: inputProfiles[i].languages),
        likeAction: () {
          sendLike(inputProfiles[i].id);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Right Swipe (Like)"),
            duration: Duration(milliseconds: 500),
          ));
        },
        nopeAction: () {
          sendDislike(inputProfiles[i].id);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Left Swipe (Nope)"),
            duration: Duration(milliseconds: 500),
          ));
        },
      ));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Profile>>(
        future: getProfile(thisPage),
        builder: (BuildContext context, AsyncSnapshot<List<Profile>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('Loading'));
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<Profile> profiles = snapshot.data!;
              initSwipeState(context, profiles);

              return SwipeCards(
                matchEngine: _matchEngine,
                itemBuilder: (BuildContext context, int index) {
                  Profile profile = _swipeItems[index].content;
                  return SingleChildScrollView(
                      child: Container(
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Column(children: [
                            Image.network(
                              'http://h2973117.stratoserver.net:8080' +
                                  profiles[index].image!,
                              width: 600,
                              height: 300,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 32, left: 32, right: 32),
                              child: ProfileBuilder.buildProfile(profile),
                            )
                          ])));
                },
                onStackFinished: () {
                  setState(() {});
                },
                upSwipeAllowed: false,
                fillSpace: true,
              );
            }
          }
        });
  }
}
