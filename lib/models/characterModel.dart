import 'package:flutter/foundation.dart';

class Character {
  final int charID;
  final String name;
  final String birthDate;
  final List<String> occupation;
  final String imageURL;

  Character({
    @required this.charID,
    @required this.name,
    @required this.birthDate,
    @required this.occupation,
    @required this.imageURL,
  });

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        charID: json["char_id"],
        name: json["name"],
        birthDate: json["birthday"],
        occupation: List<String>.from(json["occupation"].map((x) => x)),
        imageURL: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "char_id": charID,
        "name": name,
        "birthday": birthDate,
        "occupation": List<dynamic>.from(occupation.map((x) => x)),
        "img": imageURL,
      };
}
