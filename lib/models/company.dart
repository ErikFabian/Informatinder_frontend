class Company {
  int id;
  String image;
  String name;
  String location;
  String description;
  String website;
  List<String> languages = [];
  List<String> benefits = [];
  List<String> categories = [];

  Company(
      {required this.id,
      required this.image,
      required this.name,
      required this.location,
      required this.description,
      required this.website,
      required this.languages,
      required this.benefits,
      required this.categories});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      location: json['location'],
      description: json['description'],
      website: json['website'],
      languages: json['languages'],
      benefits: json['benefits'],
      categories: json['categories'],
    );
  }
}
