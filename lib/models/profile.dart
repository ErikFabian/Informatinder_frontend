class Profile {
  int id;
  String name;
  String description;
  bool isBetrieb;

  Profile({
    required this.id,
    required this.name,
    required this.description,
    required this.isBetrieb,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['profile']['id'],
      name: json['profile']['name'],
      description: json['profile']['description'],
      isBetrieb: json['profile']['isBetrieb'],
    );
  }
}
