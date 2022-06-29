import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/language.dart';
import 'package:frontend_flutter/models/profile.dart';

class ProfileBuilder {
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
                      color: Colors.blue[50],
                      child: Center(child: ui[index]),
                    )
                  : const SizedBox.shrink();
            },
            separatorBuilder: (BuildContext context, int index) =>
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
      profile.name == null || profile.name == "" ? null : Text(profile.name!),
      profile.website == null || profile.website == ""
          ? null
          : Text(profile.website!),
      profile.location == null || profile.location == ""
          ? null
          : Text(profile.location!),
      profile.description == null || profile.description == ""
          ? null
          : Text(profile.description!),
      profile.contact == null || profile.contact == ""
          ? null
          : Text(profile.contact!),
      Items("CATEGORIES", (profile.categories ??= [])),
      Items("LANGUAGES", buildCompanyLanguage(profile.languages!)),
      Items("BENEFITS", (profile.benefits ??= [])),
    ];
  }

  static List<String>? buildCompanyLanguage(List<Language>? list) {
    List<String>? newList = [];
    list?.forEach((element) {
      newList.add(element.name!);
    });
    return newList;
  }

  static List<Widget?> buildApplicant(Profile profile) {
    return [
      profile.name == null || profile.name == "" ? null : Text(profile.name!),
      profile.website == null || profile.website == ""
          ? null
          : Text(profile.website!),
      profile.location == null || profile.location == ""
          ? null
          : Text(profile.location!),
      profile.description == null || profile.description == ""
          ? null
          : Text(profile.description!),
      profile.contact == null || profile.contact == ""
          ? null
          : Text(profile.contact!),
      ItemsFromMap("LANGUAGES", profile.languages),
      Items("CATEGORIES", (profile.categories ??= [])),
    ];
  }

  static List<String>? buildApplicantLanguage(List<Language>? list) {
    List<String>? newList = [];
    list?.forEach((element) {
      newList.add(element.name!);
    });
    return newList;
  }

  static Widget Headline(String headline) {
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

  static Widget EditableLanguageExperience(
      double experience, changeExperience) {
    return Slider(
      value: experience,
      min: 1,
      max: 10,
      divisions: 9,
      label: ("Level: " + (experience).round().toString()),
      onChanged: (double value) => changeExperience(value),
    );
  }

  static Widget EditableText(String tag, String? editable, changeEditable) {
    final controller = TextEditingController(text: editable ??= "");
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

  static Widget EditableItem(String field, editable, deleteEditable) {
    return GestureDetector(
        child: Container(
            decoration: ItemDecoration(field, editable),
            padding: const EdgeInsets.all(8.0),
            child: field == "EXPERIENCE" ? Text(editable.key) : Text(editable)),
        onTap: () => field == "EXPERIENCE"
            ? deleteEditable(editable.key)
            : deleteEditable(editable));
  }

  static Widget EditableItems(
      String field, List<String> editables, deleteEditable) {
    if (editables.isEmpty) {
      return const SizedBox(height: 10);
    } else {
      List<Widget> widgets = [];
      for (var editable in editables) {
        widgets.add(EditableItem(field, editable, deleteEditable));
      }
      return Column(
          children: [Wrap(spacing: 10, children: widgets)],
          crossAxisAlignment: CrossAxisAlignment.start);
    }
  }

  static Widget EditableMapItems(
      String field, List<Language> editables, deleteEditable) {
    if (editables.isEmpty) {
      return const SizedBox(height: 10);
    } else {
      List<Widget> widgets = [];

      editables.forEach((element) {
        widgets.add(LanguageExperience(element, deleteEditable));
      });

      return Column(children: [
        Wrap(spacing: 10, children: widgets),
      ], crossAxisAlignment: CrossAxisAlignment.start);
    }
  }

  static Widget EditableLanguageSection(
      String field, List<Language> editables, addEditable, deleteEditable) {
    final controller = TextEditingController();
    return Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Headline(field),
            const SizedBox(height: 30),
            EditableItems(
                field, buildCompanyLanguage(editables)!, deleteEditable),
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

  static Widget EditableSection(
      String field, List<String> editables, addEditable, deleteEditable) {
    final controller = TextEditingController();
    return Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Headline(field),
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
      List<Language> editables,
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
            Headline(field),
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

  static Widget LanguageExperience(language, deleteLanguage) {
    return GestureDetector(
      child: Wrap(
        direction: Axis.horizontal,
        crossAxisAlignment: WrapCrossAlignment.end,
        spacing: 5,
        runSpacing: 5,
        children: [
          Text(language.name),
          Container(
              child: LinearProgressIndicator(
            value: language.experience.toDouble() * 0.1,
            backgroundColor: Colors.blue[100],
            color: Colors.blue[800],
          )),
          const SizedBox(
            height: 20,
          )
        ],
      ),
      onTap: () => deleteLanguage(language.name),
    );
  }

  static Widget LanguageItem(Language language) {
    return Wrap(
      direction: Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.end,
      spacing: 5,
      runSpacing: 5,
      children: [
        Text(language.name!),
        Container(
            child: LinearProgressIndicator(
          value: language.experience!.toDouble() * 0.1,
          backgroundColor: Colors.blue[100],
          color: Colors.blue[800],
        )),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  static Widget Item(String field, editable) {
    return Container(
        decoration: ItemDecoration(field, editable),
        padding: const EdgeInsets.all(8.0),
        child: field == "EXPERIENCE" ? Text(editable.key) : Text(editable));
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

  static Widget? ItemsFromMap(String field, List<Language>? languages) {
    if (languages == null || languages.isEmpty) {
      return null;
    } else {
      List<Widget> widgets = [];

      languages.forEach((element) {
        widgets.add(LanguageItem(element));
      });

      return Column(
          children: [Wrap(spacing: 10, children: widgets)],
          crossAxisAlignment: CrossAxisAlignment.start);
    }
  }

// COLOR FUNCTIONS

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
        return BoxDecoration(color: getLanguageColor(editable.key));
      default:
        return BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: Colors.white);
    }
  }

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
        color = Colors.white;
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
        color = Colors.white;
        break;
    }
    return color;
  }
}
