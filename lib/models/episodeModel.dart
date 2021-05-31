import 'package:flutter/foundation.dart';

class Episode {
  final int episodeID;
  final String title;
  final String airDate;
  final String season;
  final List<String> characters;

  Episode({
    @required this.episodeID,
    @required this.title,
    @required this.airDate,
    @required this.season,
    @required this.characters,
  });

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        episodeID: json["episode_id"],
        title: json["title"],
        airDate: json["air_date"],
        season: json["season"],
        characters: List<String>.from(json["characters"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "episode_id": episodeID,
        "title": title,
        "air_date": airDate,
        "season": season,
        "characters": List<dynamic>.from(characters.map((x) => x)),
      };
}
