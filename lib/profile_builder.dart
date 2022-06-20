import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/profile.dart';

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

  static Widget builder(List<Widget?> ui) {
    return Container(
        padding: const EdgeInsets.all(0),
        child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            itemCount: ui.length,
            itemBuilder: (BuildContext context, int index) {
              return ui[index] != null
                  ? Container(
                      padding: const EdgeInsets.all(15),
                      // height: 70,
                      color: Colors.blue[50],
                      child: Center(child: ui[index]),
                    )
                  : const SizedBox.shrink();
            },
            separatorBuilder: (BuildContext context, int index) =>
                // const Divider(),
                const SizedBox(
                  height: 10,
                )));
  }

  static Widget buildProfile(Profile profile) {
    return builder(
        profile.isBetrieb ? buildCompany(profile) : buildApplicant(profile));
  }

  static List<Widget?> buildCompany(Profile profile) {
    return [
      Text(profile.name ??= "No name yet"),
      Text(profile.website ??= "No website yet"),
      ProfileBuilder.Items("CATEGORIES", profile.categories!),
      ProfileBuilder.Items("LANGUAGES", profile.languagesCompany!),
      ProfileBuilder.Items("BENEFITS", profile.benefits!),
      Text(profile.description ??= "No description yet"),
      Text(profile.location ??= "No location yet"),
    ];
  }

  static List<Widget?> buildApplicant(Profile profile) {
    return [
      ItemsFromMap("EXPERIENCE", profile.languagesApplicant),
      Items("CATEGORIES", profile.categories),
      profile.name == null || profile.name == "" ? null : Text(profile.name!),
      profile.website == null || profile.website == ""
          ? null
          : Text(profile.website!),
      profile.description == null || profile.description == ""
          ? null
          : Text(profile.description!)
    ];
  }

  static Widget EditableBenefitElement(String benefit, deleteBenefit) {
    return GestureDetector(
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: Colors.white),
            padding: const EdgeInsets.all(8.0),
            child: Text(benefit)),
        onTap: () => deleteBenefit(benefit));
  }

  static Border buildBorderFromExperience(int experience) {
    switch (experience) {
      case 1:
        return const Border(
          left: BorderSide(width: 2.5, color: Color.fromARGB(255, 0, 243, 121)),
          bottom:
              BorderSide(width: 2.5, color: Color.fromARGB(255, 223, 14, 14)),
          right:
              BorderSide(width: 2.5, color: Color.fromARGB(255, 223, 14, 14)),
          top: BorderSide(width: 2.5, color: Color.fromARGB(255, 223, 14, 14)),
        );
      case 2:
        return const Border(
          left: BorderSide(width: 2.5, color: Color.fromARGB(255, 0, 243, 121)),
          top: BorderSide(width: 2.5, color: Color.fromARGB(255, 0, 243, 121)),
          right:
              BorderSide(width: 2.5, color: Color.fromARGB(255, 223, 14, 14)),
          bottom:
              BorderSide(width: 2.5, color: Color.fromARGB(255, 223, 14, 14)),
        );
      case 3:
        return const Border(
          left: BorderSide(width: 2.5, color: Color.fromARGB(255, 0, 243, 121)),
          top: BorderSide(width: 2.5, color: Color.fromARGB(255, 0, 243, 121)),
          right:
              BorderSide(width: 2.5, color: Color.fromARGB(255, 0, 243, 121)),
          bottom:
              BorderSide(width: 2.5, color: Color.fromARGB(255, 223, 14, 14)),
        );
      case 4:
        return const Border(
          left: BorderSide(width: 2.5, color: Color.fromARGB(255, 0, 243, 121)),
          top: BorderSide(width: 2.5, color: Color.fromARGB(255, 0, 243, 121)),
          right:
              BorderSide(width: 2.5, color: Color.fromARGB(255, 0, 243, 121)),
          bottom:
              BorderSide(width: 2.5, color: Color.fromARGB(255, 0, 243, 121)),
        );

      default:
        return const Border(
          bottom: BorderSide.none,
          right: BorderSide.none,
          top: BorderSide.none,
          left: BorderSide.none,
        );
    }
  }

  static Widget buildHeadline(String headline) {
    return Column(
      children: [
        const SizedBox(height: 15),
        Text(
          headline.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  static Widget EditableSection(
      String field, List<String> editables, addEditable, deleteEditable) {
    final controller = TextEditingController();
    return Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildHeadline(field),
            const SizedBox(height: 30),
            EditableItems(field, editables, deleteEditable),
            const SizedBox(height: 30),
            TextField(
                controller: controller,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => addEditable(controller.text.toUpperCase()),
                )))
          ],
        ));
  }

  static Widget EditableMapSection(
      String field,
      Map<String, int> editables,
      addEditable,
      deleteEditable,
      newExperience,
      newLanguage,
      changeExperience,
      changeLanguage) {
    final controller = TextEditingController();
    return Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildHeadline(field),
            const SizedBox(height: 30),
            EditableMapItems(field, editables, deleteEditable),
            const SizedBox(height: 30),
            EditableLanguageExperience(newExperience, changeExperience),
            const SizedBox(height: 30),
            TextField(
                controller: controller,
                // onChanged: (value) => changeLanguage(value),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => addEditable(controller.text.toUpperCase()),
                )))
          ],
        ));
  }

  static Widget EditableLanguageExperience(
      double experience, changeExperience) {
    return Slider(
      value: experience,
      min: 1,
      max: 4,
      divisions: 3,
      label: ("Level: " + (experience).round().toString()),
      onChanged: (double value) => changeExperience(value),
    );
  }

  static Widget EditableItems(
      String field, List<String> editables, deleteEditable) {
    if (editables.isEmpty) {
      return const SizedBox(height: 10);
    } else {
      List<Widget> widgets = [];
      for (var editable in editables) {
        widgets.add(EditableElementWidget(field, editable, deleteEditable));
      }
      return Column(
          children: [Wrap(spacing: 10, children: widgets)],
          crossAxisAlignment: CrossAxisAlignment.start);
    }
  }

  static Widget EditableMapItems(
      String field, Map<String, int> editables, deleteEditable) {
    if (editables.isEmpty) {
      return const SizedBox(height: 10);
    } else {
      List<Widget> widgets = [];
      for (var editable in editables.entries) {
        widgets.add(EditableElementWidget(field, editable, deleteEditable));
      }
      return Column(
          children: [Wrap(spacing: 10, children: widgets)],
          crossAxisAlignment: CrossAxisAlignment.start);
    }
  }

  static Widget? Items(String field, List<String>? items) {
    if (items == null || items.isEmpty) {
      return null;
    } else {
      List<Widget> widgets = [];
      for (var item in items) {
        widgets.add(Item(field, item));
      }
      return Column(
          children: [Wrap(spacing: 10, children: widgets)],
          crossAxisAlignment: CrossAxisAlignment.start);
    }
  }

  static Widget? ItemsFromMap(String field, Map<String, int>? items) {
    if (items == null || items.isEmpty) {
      return null;
    } else {
      List<Widget> widgets = [];
      for (var item in items.entries) {
        widgets.add(Item(field, item));
      }
      return Column(
          children: [Wrap(spacing: 10, children: widgets)],
          crossAxisAlignment: CrossAxisAlignment.start);
    }
  }

  static Widget EditableExperience(int experience, changeExperience) {
    return Row(
      children: [
        const Text("EXPERIENCE"),
        Slider(
          value: experience.toDouble(),
          min: 0,
          max: 50,
          divisions: 51,
          label: (experience.round().toString() + " Years"),
          onChanged: (double value) => changeExperience(value),
        )
      ],
    );
  }

  static Widget EditableElementWidget(String field, editable, deleteEditable) {
    return GestureDetector(
        child: Container(
            decoration: ItemDecoration(field, editable),
            padding: const EdgeInsets.all(8.0),
            child: field == "EXPERIENCE" ? Text(editable.key) : Text(editable)),
        onTap: () => field == "EXPERIENCE"
            ? deleteEditable(editable.key)
            : deleteEditable(editable));
  }

  static Widget Item(String field, editable) {
    return Container(
        decoration: ItemDecoration(field, editable),
        padding: const EdgeInsets.all(8.0),
        child: field == "EXPERIENCE" ? Text(editable.key) : Text(editable));
  }

  static BoxDecoration ItemDecoration(String field, editable) {
    switch (field.toUpperCase()) {
      case "LANGUAGES":
        return BoxDecoration(
            border: Border.all(
              color: ProfileBuilder.getLanguageColor(editable)!,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: getLanguageColor(editable));
      case "CATEGORIES":
        return BoxDecoration(color: getInterestColor(editable));
      case "EXPERIENCE":
        return BoxDecoration(
            border: buildBorderFromExperience(editable.value),
            color: getLanguageColor(editable.key));
      default:
        return BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: Colors.white);
    }
  }

  static Widget EditableLanguageElement(String language, deleteEditable) {
    return GestureDetector(
        child: Container(
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
            )));
  }

  static Widget EditableText(String tag, String? editable, changeEditable) {
    final controller = TextEditingController(text: editable!);
    return Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Text(tag),
          TextField(
            controller: controller,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
                suffixIcon: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => changeEditable(controller.text),
            )),
          )
        ]));
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
