class Profile {
  int id;
  String firstname;
  String lastname;
  String description;
  bool isBetrieb;

  Profile({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.description,
    required this.isBetrieb,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['name'],
      description: json['description'],
      isBetrieb: json['benefits'],
    );
  }
}
