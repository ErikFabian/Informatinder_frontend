class Language {
  int? id = 0;
  String? name = "";
  int? experience = 0;

  getName() {
    return name ??= "";
  }

  Language({this.id, this.name, this.experience});
}
