import 'package:flutter/material.dart';

import 'models/applicant.dart';

class ProfileBuilder {
/* BUILD APPLICANT PROFILE

    BUILD A WIDGET LIST TO PASS TO A WIDGET AS CHILDREN

        List<Widget> buildProfile(Applicant applicant) {
            return [
              ProfileBuilder.buildExperienceSection(applicant.experience),
              ProfileBuilder.buildHeadline("INTERESSEN"),
              ProfileBuilder.buildInterestSection(applicant.categories),
              ProfileBuilder.buildHeadline("SPRACHEN"),
              ProfileBuilder.buildLanguageSection(applicant.languages),
              ProfileBuilder.buildHeadline("ÜBER MICH"),
              ProfileBuilder.buildAboutMe(
                  applicant.name, applicant.website, applicant.description)
            ];
          }

    TESTING

    final Applicant applicant = Applicant(
      id: 0,
      image: "/link/to/image",
      name: "Max Mustermann",
      description:
          "Ich bin ein solider Informatiker. Nicht mehr, nicht weniger",
      website: "www.website.com",
      languages: {"Java": 1, "GO": 2, "Vue": 3, "Flutter": 4, "Node": 5},
      experience: 4,
      categories: ["Backend", "IOS", "Frontend"]);




    BUILD COMPANY PROFILE 
    BUILD A WIDGET LIST TO PASS TO A WIDGET AS CHILDREN

        List<Widget> buildProfile(Company company) {
          return [
            ProfileBuilder.buildHeadline("ANGEBOTE"),
            ProfileBuilder.buildInterestSection(company.categories),
            ProfileBuilder.buildHeadline("SPRACHEN"),
            ProfileBuilder.buildLanguageSectionFromList(company.languages),
            ProfileBuilder.buildHeadline("BENEFITS"),
            ProfileBuilder.buildBenefitSection(company.benefits),
            ProfileBuilder.buildHeadline("ÜBER UNS"),
            ProfileBuilder.buildAboutUs(
                company.name, company.website, company.location, company.description)
          ];
  }

    TESTING

    final Company company = Company(
      id: 0,
      image: "/link/to/image",
      name: "TESTFIRMA",
      location: "Flensburg",
      description:
          "Ich bin ein solider Informatiker. Nicht mehr, nicht weniger",
      website: "www.website.com",
      languages: ["Node", "Angular", "Vue"],
      categories: ["Backend", "Frontend"],
      benefits: ["HOMEOFFICE", "KAFFEE", "FITNESS"]);

*/

// WIDGET FUNCTIONS

  static Widget buildInterestElement(String interest) {
    return Container(
        decoration: BoxDecoration(color: getInterestColor(interest)),
        padding: const EdgeInsets.all(8.0),
        child: Text(interest));
    ;
  }

  static Widget buildBenefitElement(String benefit) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: Colors.white),
        padding: const EdgeInsets.all(8.0),
        child: Text(benefit));
  }

  static Widget buildLanguageElementFromMap(
      String language, double experience) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: ProfileBuilder.getLanguageColor(language)!,
                width: experience),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: Colors.white),
        padding: const EdgeInsets.all(8.0),
        child: Text(language));
  }

  static Widget buildLanguageElementFromString(String language) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: ProfileBuilder.getLanguageColor(language)!,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: getLanguageColor(language)),
        padding: const EdgeInsets.all(8.0),
        child: Text(
          language,
          style: const TextStyle(color: Colors.white),
        ));
  }

  static Widget buildHeadline(String headline) {
    return Column(
      children: [
        const SizedBox(height: 15),
        Text(headline.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            )),
        const SizedBox(height: 15)
      ],
    );
  }

  static Widget buildExperienceSection(int experience) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: Colors.black),
        padding: const EdgeInsets.all(8.0),
        child: Text("Seit " + experience.toString() + " Jahren Informatiker",
            style: const TextStyle(
              color: Colors.white,
            )));
  }

  static Widget buildBenefitSection(List<String> benefits) {
    List<Widget> widgets = [];
    for (var benefit in benefits) {
      widgets.add(buildBenefitElement(benefit));
    }
    return Wrap(spacing: 10, children: widgets);
    ;
  }

  static Widget buildLanguageSectionFromMap(Map<String, double> languages) {
    List<Widget> widgets = [];
    for (var language in languages.keys) {
      widgets.add(buildLanguageElementFromMap(language, languages[language]!));
    }
    return Wrap(spacing: 10, children: widgets);
    ;
  }

  static Widget buildLanguageSectionFromList(List<String> languages) {
    List<Widget> widgets = [];
    for (var language in languages) {
      widgets.add(buildLanguageElementFromString(language));
    }
    return Wrap(spacing: 10, children: widgets);
    ;
  }

  static Widget buildInterestSection(List<String> interests) {
    List<Widget> widgets = [];
    for (var interest in interests) {
      widgets.add(buildInterestElement(interest));
    }
    return Wrap(spacing: 10, children: widgets);
  }

  static Widget buildAboutMe(String name, String website, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Wrap(
          spacing: 45,
          children: [
            const Text(
              "NAME",
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.w300),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 25,
          children: [
            const Text(
              "WEBSITE",
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
            Text(
              website,
              style: const TextStyle(fontWeight: FontWeight.w300),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          description,
          style: const TextStyle(fontWeight: FontWeight.w300),
        ),
      ],
    );
  }

  static Widget buildAboutUs(
      String name, String website, String location, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Wrap(
          spacing: 45,
          children: [
            const Text(
              "NAME",
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.w300),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 25,
          children: [
            const Text(
              "WEBSITE",
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
            Text(
              website,
              style: const TextStyle(fontWeight: FontWeight.w300),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 55,
          children: [
            const Text(
              "ORT",
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
            Text(
              location,
              style: const TextStyle(fontWeight: FontWeight.w300),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          description,
          style: const TextStyle(fontWeight: FontWeight.w300),
        ),
      ],
    );
  }

// COLOR FUNCTIONS

  static Color? getLanguageColor(String language) {
    Color? color;

    switch (language.toLowerCase()) {
      case "java":
        color = Colors.blue[400];
        break;
      case "node":
        color = Colors.green[400];
        break;
      case "go":
        color = Colors.yellow[400];
        break;
      case "c#":
        color = Colors.red[400];
        break;
      case "angular":
        color = Colors.deepOrange[400];
        break;
      case "vue":
        color = Colors.lightGreen[400];
        break;
      case "flutter":
        color = Colors.lightBlue[400];
        break;
      default:
        color = Colors.black;
        break;
    }
    return color;
  }

  static Color? getInterestColor(String interest) {
    Color? color;

    switch (interest.toLowerCase()) {
      case "backend":
        color = Colors.blue[400];
        break;
      case "frontend":
        color = Colors.green[400];
        break;
      case "ios":
        color = Colors.yellow[400];
        break;
      case "android#":
        color = Colors.red[400];
        break;
      case "itsec":
        color = Colors.deepOrange[400];
        break;
      case "network":
        color = Colors.lightGreen[400];
        break;
      case "architecture":
        color = Colors.lightBlue[400];
        break;
      default:
        color = Colors.black;
        break;
    }
    return color;
  }
}
