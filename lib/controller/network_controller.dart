import 'package:frontend_flutter/controller/user_preferences.dart';
import 'package:frontend_flutter/models/user.dart';
import 'package:frontend_flutter/models/language.dart';
import 'package:frontend_flutter/models/profile.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

class NetworkController {
  // GET OWN PROFILE FROM SERVER WITH ID

  static Future<Profile> getProfile() async {
    String? id = await UserPreferences().getId();
    Profile profile;

    final response = await http.get(
      Uri.parse(
          'http://h2973117.stratoserver.net:8080/profile/' + id.toString()),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      profile = Profile.fromJson(responseData['profile']);

      List iterLanguages = responseData['languages'];
      profile.languages = List<Language>.from(
          iterLanguages.map((element) => Language.fromJson(element)));

      List iterBenefits = responseData['benefits'];
      profile.benefits =
          List<String>.from(iterBenefits.map((element) => element.toString()));

      List iterCategories = responseData['categories'];
      profile.categories = List<String>.from(
          iterCategories.map((element) => element.toString()));

      return profile;
    } else {
      throw Exception("No Profile found");
    }
  }

  // UPDATE OWN PROFILE WITH ID AND TOKEN AND UPDATED INFORMATION
  // TAKES NEW PROFILE AS ARGUMENT

  static Future<Profile> updateProfile(Profile profile) async {
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
          'contact': profile.contact ??= "",
          'location': profile.location ??= "",
          'description': profile.description ??= "",
          'benefits': Profile.listToString(profile.benefits ??= []),
          'categories': Profile.listToString(profile.categories ??= []),
          'languages': Profile.languagesToString(profile.languages ??= []),
          'isBetrieb': profile.isBetrieb.toString()
        }));

    if (response.statusCode == 200) {
      return profile;
    } else if (response.statusCode == 404) {
      throw Exception("No Profile found");
    } else {
      throw Exception(response.statusCode);
    }
  }

  static uploadImage(File imageFile) async {
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

  static Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://h2973117.stratoserver.net:8080/user/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      User user = User.fromJson(responseData);
      UserPreferences().saveUser(user);

      return true;
    } else {
      return false;
    }
  }

  static Future<List<Profile>> getMatches() async {
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

  static Future<bool> register(String email, String username, String password,
      String confirmPassword, bool isBetrieb) async {
    final response = await http.post(
      Uri.parse('http://h2973117.stratoserver.net:8080/user/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'username': username,
        'password': password,
        'confirmPassword': confirmPassword,
        'isBetrieb': isBetrieb.toString()
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      // UserPreferences().saveUser();

      return true;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to register.');
    }
  }
}
