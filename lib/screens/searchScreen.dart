import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_breakingbad_app/models/characterModel.dart'
    show Character;
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
  Future<List<Character>> getSingleCharacter(String characterName) async {
    final response =
        await http.get(Uri.parse("${API}/characters?name=${characterName}"));
    List jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      return jsonResponse
          .map((element) => Character.fromJson(element))
          .toList();
    } else {
      throw Exception("Failed To Load Characters");
    }
  }

  void _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 300,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Note :- This Search Screen Page Show All Character Who are Present in Breaking Bad TV Series and You Can Also Search For Specific Characters \n\nPlease Forgive Me If My Design Is Not Perfect, I am Trying to Improve MySelf on Daily Basis.",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        });
  }

  void submit() async {
    String text = textController.text;
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      await getSingleCharacter(text);
    }
  }

  @override
  void dispose() {
    textController.dispose(); // Disposing TextEditingController
    super.dispose();
  }

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
                      hintText: "Search Character",
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
                width: (MediaQuery.of(context).size.width as double) * 0.95,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      submit();
                    });
                  },
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
                  height: 150.0,
                  child: FutureBuilder(
                    future: getSingleCharacter(textController.text),
                    builder: (_, snapshot) {
                      return snapshot.hasData
                          ? ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (_, index) {
                                return Card(
                                  child: Stack(
                                    children: <Widget>[
                                      CachedNetworkImage(
                                        imageUrl: snapshot.data[index].imageURL,
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        child: Container(
                                          width: 430,
                                          height: 50,
                                          color: Colors.black54,
                                          padding: EdgeInsets.all(5.0),
                                          child: Text(
                                            snapshot.data[index].name,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            )
                          : Text("Search For Character");
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _showModalSheet,
          label: Text("Please Open Me First"),
          backgroundColor: Colors.green,
        ));
  }
}
