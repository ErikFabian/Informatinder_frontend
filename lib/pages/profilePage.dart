import 'package:flutter/material.dart';
import 'package:frontend_flutter/views/profile_builder.dart';
import 'package:frontend_flutter/models/profile.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class profilePage extends StatelessWidget {
  final Profile profile;

  const profilePage({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text("InformaTinder")),
        body: SingleChildScrollView(
            child: Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(children: [
                  Image.network(
                    'http://h2973117.stratoserver.net:8080' + profile.image!,
                    width: 600,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(top: 32, left: 32, right: 32),
                    child: ProfileBuilder.buildProfile(profile),
                  )
                ]))));
  }
}
