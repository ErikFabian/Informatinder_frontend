class Applicant {
  int id;
  String image;
  String name;
  String description;
  String website;
  Map<String, double> languages;
  List<String> categories = [];
  int experience;

  Applicant(
      {required this.id,
      required this.image,
      required this.name,
      required this.description,
      required this.website,
      required this.languages,
      required this.experience,
      required this.categories});

  factory Applicant.fromJson(Map<String, dynamic> json) {
    return Applicant(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      description: json['description'],
      website: json['website'],
      languages: json['languages'],
      experience: json['experience'],
      categories: json['categories'],
    );
  }
}
