import 'package:flutter/material.dart';
import 'package:frontend_flutter/controller/network_controller.dart';
import 'package:frontend_flutter/models/profile.dart';
import 'package:frontend_flutter/pages/profile_page.dart';

class MatchesPage extends StatelessWidget {
  const MatchesPage({Key? key}) : super(key: key);

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
                          builder: (BuildContext context) => ProfilePage(
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
        future: NetworkController.getMatches(),
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
