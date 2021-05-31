import 'package:flutter/foundation.dart';

class Episode {
  final int episodeID;
  final String title;
  final String airDate;
  final List<String> characters;

  Episode({
    @required this.episodeID,
    @required this.title,
    @required this.airDate,
    @required this.characters,
  });

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        episodeID: json["episode_id"],
        title: json["title"],
        airDate: json["air_date"],
        characters: List<String>.from(json["characters"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "episode_id": episodeID,
        "title": title,
        "air_date": airDate,
        "characters": List<dynamic>.from(characters.map((x) => x)),
      };
}
