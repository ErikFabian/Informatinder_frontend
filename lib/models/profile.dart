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
      image: json['image'] ? json['image'] : "",
      name: json['name'] ? json['name'] : "Unbekannt",
      description: json['description'] ? json['description'] : "",
      website: json['website'] ? json['website'] : "",
      languagesApplicant:
          json['languagesApplicant'] ? json['languagesApplicant'] : [],
      languagesCompany:
          json['languagesCompany'] ? json['languagesCompany'] : [],
      experience: json['experience'] ? json['experience'] : 0,
      categories: json['categories'] ? json['categories'] : [],
      benefits: json['benefits'] ? json['benefits'] : [],
      location: json['location'] ? json['location'] : [],
      isBetrieb: json['isBetrieb'] ? json['isBetrieb'] : [],
    );
  }
}
