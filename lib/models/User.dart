class User {
  int id;
  String username;
  String email;
  String token;

  User(
      {required this.id,
      required this.username,
      required this.email,
      required this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'],
      username: json['user']['username'],
      email: json['user']['email'],
      token: json['token'],
    );
  }
}
