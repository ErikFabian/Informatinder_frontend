import 'package:frontend_flutter/models/language.dart';

class Profile {
  int id;
  String? image;
  String? name;
  String? description;
  String? website;
  String? location;
  String? contact;
  List<Language>? languages = [];
  List<String>? categories = [];
  List<String>? benefits = [];
  bool isBetrieb;

  Profile(
      {required this.id,
      this.image,
      this.name,
      this.description,
      this.website,
      this.languages,
      this.benefits,
      this.categories,
      this.location,
      this.contact,
      required this.isBetrieb});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] != Null ? json['id'] : "",
      image: json['image'] != Null ? json['image'] : "",
      name: json['name'] != Null ? json['name'] : "Unbekannt",
      description: json['description'] != Null ? json['description'] : "",
      website: json['website'] != Null ? json['website'] : "",
      contact: json['contact'] != Null ? json['contact'] : "",
      languages: json['languages'] != Null ? json['languagesApplicant'] : {},
      categories: json['categories'] != Null ? json['categories'] : [],
      benefits: json['benefits'] != Null ? json['benefits'] : [],
      location: json['location'] != Null ? json['location'] : [],
      isBetrieb: json['isBetrieb'] != Null ? json['isBetrieb'] : [],
    );
  }

  // LIST OF BENEFITS OR CATEGORIES TO STRING
  static String listToString(List<String> list) {
    String returnValue = "[";

    for (int i = 0; i < list.length - 1; i++) {
      returnValue += "\"" + list[i] + "\"" + ",";
    }
    if (list.isNotEmpty) {
      returnValue += "\"" + list[list.length - 1] + "\"";
    }

    return returnValue + "]";
  }

  // LIST OF LANGUAGES TO STRING
  static String languagesToString(List<Language> list) {
    String returnValue = "{";

    for (int i = 0; i < list.length - 1; i++) {
      returnValue +=
          "\"" + list[i].name! + "\":" + list[i].experience!.toString() + ",";
    }
    if (list.isNotEmpty) {
      returnValue += "\"" +
          list[list.length - 1].name! +
          "\":" +
          list[list.length - 1].experience!.toString();
    }

    return returnValue + "}";
  }
}
