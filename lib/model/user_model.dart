import 'dart:convert';

class User {
  final String? userid;
  final String name;
  final String email;
  final String password;
  final String? image;

  User({
    required this.userid,
    required this.name,
    required this.email,
    required this.password,
    required this.image,
  });

  factory User.fromJson(Map<String, String> json) {
    return User(
        userid: json["userid"],
        name: json["name"]!,
        email: json["email"]!,
        password: json["password"]!,
        image: jsonDecode(json["file"] ?? "null"));
  }

  Map<String, String> toJson() {
    return {"name": name, "email": email, "password": password};
  }
}
