import 'package:flutter/material.dart';
import 'package:flutter_breakingbad_app/models/characterModel.dart'
    show Character;
import 'package:flutter_breakingbad_app/widgets/characterCard.dart';
import 'package:http/http.dart' as http;
import '../API.dart' show API;
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  static const routeName = "/SearchScreen";
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final textController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();
  List<Character> breakingBadCharacters = [];

  Future<void> getSingleCharacter(String characterName) async {
    final response =
        await http.get(Uri.parse("${API}/characters?name=${characterName}"));
    List jsonResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      // return jsonResponse
      //     .map((element) => Character.fromJson(element))
      //     .toList();
      for (var singleCharacter in jsonResponse) {
        breakingBadCharacters.add(singleCharacter);
      }
    } else {
      throw Exception("Failed To Load Characters");
    }
  }

  void submit() async {
    String text = textController.text;
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      await getSingleCharacter(text);
    }
  }

  Widget buildSwitches() {
    return Container(
      width: 400,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Characters",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Switch(
                value: true,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Episodes",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Switch(
                value: false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget buildCharacterViewWidget() {
  //   return Container(
  //     width: 350,
  //     child: ListView.builder(
  //       itemCount: badCharacters.length,
  //       itemBuilder: (_, index) {
  //         return CharacterCard(
  //           characterName: badCharacters[index][index].name,
  //           imageURL: badCharacters[index].imageURL,
  //           birthday: badCharacters[index].birthDate,
  //           occupation: badCharacters[index].occupation,
  //         );
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                ),
                borderRadius: BorderRadius.circular(50.0),
              ),
              margin: EdgeInsets.only(
                top: 20,
                bottom: 20,
                left: 10,
                right: 10,
              ),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: textController,
                  cursorColor: Colors.black,
                  validator: (String value) {
                    if (value.isEmpty) return "Please Enter Something";
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search Character or Episode",
                    contentPadding: EdgeInsets.all(20),
                    hintStyle: TextStyle(
                      fontSize: 18,
                    ),
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            Container(
              width: 400,
              child: ElevatedButton(
                onPressed: () => submit(),
                child: Text(
                  "Search",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color.fromRGBO(255, 74, 74, 1),
                  ),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 200.0,
                child: ListView.builder(
                  itemCount: breakingBadCharacters.length,
                  itemBuilder: (_, index) {
                    return CharacterCard(
                      characterName: breakingBadCharacters[index].name,
                      imageURL: breakingBadCharacters[index].imageURL,
                      birthday: breakingBadCharacters[index].birthDate,
                      occupation: breakingBadCharacters[index].occupation,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
