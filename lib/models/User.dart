class User {
  String email;
  String password;
  String token;

  User({required this.email, required this.password, required this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      password: json['password'],
      token: json['token'],
    );
  }
}