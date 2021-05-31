import 'package:flutter/material.dart';
import 'package:flutter_breakingbad_app/screens/characterScreen.dart';
import 'package:flutter_breakingbad_app/screens/episodeScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          centerTitle: true,
          title: Text(
            "Breaking Bad",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: "Character",
              ),
              Tab(
                text: "Episode",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            CharacterScreen(),
            EpisodeScreen(),
          ],
        ),
      ),
    );
  }
}
