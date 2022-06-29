import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/language.dart';
import 'package:frontend_flutter/models/profile.dart';
import 'package:frontend_flutter/profile_builder.dart';
import 'package:frontend_flutter/userPreferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class EditableProfile extends StatefulWidget {
  const EditableProfile({Key? key, required this.data}) : super(key: key);

  final Profile data;

  @override
  _EditableProfileState createState() => _EditableProfileState();
}

class _EditableProfileState extends State<EditableProfile> {
  final nameController = TextEditingController();

  Profile? profile;
  List<Widget> ui = [];

  String _newLanguage = "";
  double _newExperience = 1;

  void _addBenefit(benefit) {
    setState(() {
      profile?.benefits?.add(benefit);
    });
  }

  void _deleteBenefit(benefit) {
    setState(() {
      profile?.benefits?.removeWhere((element) => element == benefit);
    });
  }

  void _addCategory(category) {
    setState(() {
      profile?.categories?.add(category);
    });
  }

  void _deleteCategory(category) {
    setState(() {
      profile?.categories?.removeWhere((element) => element == category);
    });
  }

  void _addCompanyLanguage(language) {
    setState(() {
      profile?.languages?.add(language);
    });
  }

  void _deleteCompanyLanguage(language) {
    setState(() {
      profile?.languages?.removeWhere((element) => element == language);
    });
  }

  void _changeName(name) {
    setState(() {
      profile?.name = name;
    });
  }

  void _changeWebsite(website) {
    setState(() {
      profile?.website = website;
    });
  }

  void _changeLocation(location) {
    setState(() {
      profile?.location = location;
    });
  }

  void _changeDescription(description) {
    setState(() {
      profile?.description = description;
    });
  }

  void _changeContact(contact) {
    setState(() {
      profile?.contact = contact;
    });
  }

  void _addApplicantLanguage(language) {
    setState(() {
      profile?.languages
          ?.add(Language(name: language, experience: _newExperience.round()));
    });
  }

  void _deleteApplicantLanguage(language) {
    setState(() {
      profile?.languages?.removeWhere(((element) => element.name == language));
    });
  }

  void _changeExperience(experience) {
    setState(() {
      _newExperience = experience;
    });
  }

  void _changeLanguage(language) {
    setState(() {
      _newLanguage = language;
    });
  }

  @override
  void initState() {
    super.initState();
    profile = widget.data;
    ui = editProfile(profile!);
  }

  List<Widget> editProfile(Profile profile) {
    return profile.isBetrieb ? editCompany(profile) : editApplicant(profile);
  }

  List<Widget> editCompany(Profile profile) {
    return [
      ProfileBuilder.EditableText("NAME", profile.name, _changeName),
      ProfileBuilder.EditableText("WEBSITE", profile.website, _changeWebsite),
      ProfileBuilder.EditableText(
          "LOCATION", profile.location, _changeLocation),
      ProfileBuilder.EditableText(
          "DESCRIPTION", profile.description, _changeDescription),
      ProfileBuilder.EditableText("CONTACT", profile.contact, _changeContact),
      ProfileBuilder.EditableSection(
          "BENEFITS", (profile.benefits ??= []), _addBenefit, _deleteBenefit),
      ProfileBuilder.EditableLanguageSection(
          "LANGUAGES",
          profile.languages ??= [],
          _addCompanyLanguage,
          _deleteCompanyLanguage),
      ProfileBuilder.EditableSection("CATEGORIES", (profile.categories ??= []),
          _addCategory, _deleteCategory),
    ];
  }

  List<Widget> editApplicant(Profile profile) {
    return [
      ProfileBuilder.EditableText("NAME", profile.name, _changeName),
      ProfileBuilder.EditableText("WEBSITE", profile.website, _changeWebsite),
      ProfileBuilder.EditableText(
          "LOCATION", profile.location, _changeLocation),
      ProfileBuilder.EditableText(
          "DESCRIPTION", profile.description, _changeDescription),
      ProfileBuilder.EditableText("CONTACT", profile.contact, _changeContact),
      ProfileBuilder.EditableMapSection(
          "EXPERIENCE",
          (profile.languages ??= []),
          _addApplicantLanguage,
          _deleteApplicantLanguage,
          _newExperience,
          _newLanguage,
          _changeExperience,
          _changeLanguage),
      ProfileBuilder.EditableSection("CATEGORIES", (profile.categories ??= []),
          _addCategory, _deleteCategory),
    ];
  }

  Widget builder() {
    final ui = editProfile(profile!);
    return ProfileBuilder.builder(ui);
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: builder());
  }
}
