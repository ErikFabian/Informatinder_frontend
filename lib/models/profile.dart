class Profile {
  int id;
  String? image;
  String? name;
  String? description;
  String? website;
  String? location;
  Map<String, int>? languagesApplicant;
  List<String>? categories = [];
  List<String>? languagesCompany = [];
  List<String>? benefits = [];
  int? experience;
  bool isBetrieb;

  Profile(
      {required this.id,
      this.image,
      this.name,
      this.description,
      this.website,
      this.languagesApplicant,
      this.experience,
      this.languagesCompany,
      this.benefits,
      this.categories,
      this.location,
      required this.isBetrieb});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      image: json['image'] != Null ? json['image'] : "",
      name: json['name'] != Null ? json['name'] : "Unbekannt",
      description: json['description'] != Null ? json['description'] : "",
      website: json['website'] != Null ? json['website'] : "",
      languagesApplicant:
          json['languagesApplicant'] != Null ? json['languagesApplicant'] : {},
      languagesCompany:
          json['languagesCompany'] != Null ? json['languagesCompany'] : [],
      experience: json['experience'] != Null ? json['experience'] : 0,
      categories: json['categories'] != Null ? json['categories'] : [],
      benefits: json['benefits'] != Null ? json['benefits'] : [],
      location: json['location'] != Null ? json['location'] : [],
      isBetrieb: json['isBetrieb'] != Null ? json['isBetrieb'] : [],
    );
  }
}
