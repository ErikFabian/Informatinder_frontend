class User {
  int id;
  String username;
  String email;
  String password;
  String token;

  User(
      {required this.id,
      required this.username,
      required this.email,
      required this.password,
      required this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user'].id,
      username: json['user'].username,
      email: json['user'].email,
      password: json['user'].password,
      token: json['token'],
    );
  }
}
