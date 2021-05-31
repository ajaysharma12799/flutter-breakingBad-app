import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class EpisodeCard extends StatelessWidget {
  final int episodeID;
  final String title;
  final String airDate;
  final String season;
  final List<String> characters;

  EpisodeCard({
    @required this.episodeID,
    @required this.title,
    @required this.airDate,
    @required this.season,
    @required this.characters,
  });

  Widget buildFrontContainer() {
    return Container(
      width: 150,
      height: 50,
      color: Colors.greenAccent,
      padding: EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Season ${season}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Title : ${title}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Release Date : ${airDate}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Characters : ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            for (var i = 0; i < characters.length; i++)
              Text(
                "${i + 1} ${characters[i]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget buildBackContainer() {
    return Container(
      width: 150,
      height: 50,
      color: Colors.blueAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Breaking Bad",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            "Season ${season}",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        front: buildFrontContainer(),
        back: buildBackContainer(),
      ),
    );
  }
}
