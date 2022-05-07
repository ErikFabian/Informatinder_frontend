class Company {
  int id;
  String image;
  String name;
  String location;
  String description;
  String languages;
  String benefits;

  Company(
      {required this.id,
      required this.image,
      required this.name,
      required this.location,
      required this.description,
      required this.languages,
      required this.benefits});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      location: json['location'],
      description: json['description'],
      languages: json['languages'],
      benefits: json['benefits'],
    );
  }
}
