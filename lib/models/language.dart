class Language {
  int? id = 0;
  String? name = "";
  int? experience = 0;

  getName() {
    return name ??= "";
  }

  Language({this.id, this.name, this.experience});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      id: json['id'],
      name: json['name'] != Null ? json['name'] : "Unbekannt",
      experience: json['experience'] != Null ? json['experience'] : "",
    );
  }
}
