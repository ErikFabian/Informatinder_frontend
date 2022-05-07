import 'dart:math';

import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:frontend_flutter/models/profile.dart';
import 'package:frontend_flutter/userPreferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class matchingPage extends StatelessWidget {
  late MatchEngine _matchEngine;
  List<SwipeItem> _swipeItems = <SwipeItem>[];

  Future<List<Profile>> getProfile(int page) async {
    String? token = await UserPreferences().getToken();

    final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/swipe/' + page.toString() + "/5"),
        headers: <String, String>{
          'x-access-token': token!,
        });

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData['profiles'];
    } else {
      throw Exception("No Profiles found");
    }
  }

  //TODO Hier daten der Profile im Stack einfügen
  void initState(BuildContext context) {
    for (int i = 0; i < 10; i++) {
      _swipeItems.add(SwipeItem(
        content: "Random Number: " +
            (Random().nextInt(255)).toString() +
            "This is Profile " +
            i.toString(),
        likeAction: () {
          //Hier like ans Backend senden
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Right Swipe (Like)"),
            duration: Duration(milliseconds: 500),
          ));
        },
        nopeAction: () {
          //Hier dislike ans Backend senden
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
    initState(context);

    return SwipeCards(
      matchEngine: _matchEngine,
      itemBuilder: (BuildContext context, int index) {
        return SingleChildScrollView(
            child: Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(children: [
                  Image.asset(
                    'images/teacher_male.png',
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
                              Container(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: const Text(
                                  '*Name*',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
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
                        enabled: false,
                        maxLines: null,
                        style: const TextStyle(fontSize: 14),
                        initialValue: _swipeItems[index].content,
                      ))
                ])));
      },
      onStackFinished: () {
        //TODO get new Stack from backend
      },
      itemChanged: (SwipeItem item, int index) {
        //TODO init the next profile from the stack
      },
      upSwipeAllowed: false,
      fillSpace: true,
    );
  }
}
