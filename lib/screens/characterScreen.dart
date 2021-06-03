import 'package:flutter/material.dart';
import 'package:flutter_breakingbad_app/models/characterModel.dart';
import 'package:flutter_breakingbad_app/widgets/characterCard.dart';
import 'package:http/http.dart' as http;
import '../API.dart' show API;
import 'dart:convert';

class CharacterScreen extends StatefulWidget {
  static const routeName = "/CharacterScreen";
  @override
  _CharacterScreenState createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  Future<List<Character>> getCharacters() async {
    final response = await http.get(Uri.parse("${API}/characters"));
    List jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      return jsonResponse
          .map((element) => Character.fromJson(element))
          .toList();
    } else {
      throw Exception("Failed To Load Characters");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FutureBuilder<List<Character>>(
            future: getCharacters(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? GridView.builder(
                      itemCount: snapshot.data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (ctx, index) {
                        return CharacterCard(
                          imageURL: snapshot.data[index].imageURL,
                          characterName: snapshot.data[index].name,
                          birthday: snapshot.data[index].birthDate,
                          occupation: snapshot.data[index].occupation,
                        );
                      })
                  : SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    );
            }),
      ),
    );
  }
}
