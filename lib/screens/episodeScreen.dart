import 'package:flutter/material.dart';
import 'package:flutter_breakingbad_app/models/episodeModel.dart';
import 'package:flutter_breakingbad_app/widgets/episodeCard.dart';
import 'package:http/http.dart' as http;
import '../API.dart' show API;
import 'dart:convert';

class EpisodeScreen extends StatefulWidget {
  static const routeName = "/EpisodeScreen";
  @override
  _EpisodeScreenState createState() => _EpisodeScreenState();
}

class _EpisodeScreenState extends State<EpisodeScreen> {
  Future<List<Episode>> getEpisodes() async {
    final response = await http.get(Uri.parse("${API}/episodes"));
    List jsonResponse = json.decode(response.body);
    print(jsonResponse);
    if (response.statusCode == 200) {
      return jsonResponse.map((element) => Episode.fromJson(element)).toList();
    } else {
      throw Exception("Failed to Load Episodes");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FutureBuilder<List<Episode>>(
          future: getEpisodes(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: snapshot.data.length,
                    itemBuilder: (ctx, index) {
                      return EpisodeCard(
                        episodeID: snapshot.data[index].episodeID,
                        title: snapshot.data[index].title,
                        airDate: snapshot.data[index].airDate,
                        season: snapshot.data[index].season,
                        characters: snapshot.data[index].characters,
                      );
                    })
                : SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlue,
                      strokeWidth: 5.0,
                    ),
                  );
          },
        ),
      ),
    );
  }
}
