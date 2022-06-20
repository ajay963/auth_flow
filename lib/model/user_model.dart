import 'dart:convert';

class UserData {
  final String uid;
  final String email;
  final String name;
  final String imageUrl;
  final int phoneNo;

  UserData({
    required this.name,
    required this.uid,
    required this.email,
    required this.imageUrl,
    required this.phoneNo,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'imageUrl': imageUrl,
      'phoneNo': phoneNo,
    };
  }

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        name: json["name"],
        uid: json["uid"],
        email: json["email"],
        imageUrl: json["imageUrl"],
        phoneNo: json["phoneNo"] as int);
  }
  String toJson() => json.encode(toMap());
}
