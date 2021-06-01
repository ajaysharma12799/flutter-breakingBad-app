import 'package:flutter/material.dart';
import 'package:flutter_breakingbad_app/screens/HomeScreen.dart';
import 'package:flutter_breakingbad_app/screens/characterScreen.dart';
import 'package:flutter_breakingbad_app/screens/episodeScreen.dart';
import 'package:flutter_breakingbad_app/screens/searchScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(255, 74, 74, 1),
        accentColor: Color.fromRGBO(31, 131, 255, 0),
      ),
      home: HomeScreen(),
      routes: <String, WidgetBuilder>{
        CharacterScreen.routeName: (ctx) => CharacterScreen(),
        EpisodeScreen.routeName: (ctx) => EpisodeScreen(),
        SearchScreen.routeName: (ctx) => SearchScreen()
      },
    );
  }
}
