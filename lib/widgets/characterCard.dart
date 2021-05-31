import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CharacterCard extends StatefulWidget {
  final String imageURL;
  final String characterName;
  final String birthday;
  final List<String> occupation;

  CharacterCard({
    @required this.imageURL,
    @required this.characterName,
    @required this.birthday,
    @required this.occupation,
  });

  @override
  _CharacterCardState createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(50.0),
                topRight: const Radius.circular(50.0),
              ),
            ),
            context: context,
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Container(
                          width: 300,
                          height: 300,
                          child: CachedNetworkImage(
                            imageUrl: widget.imageURL,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Name : ${widget.characterName}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Birthday : ${widget.birthday}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Occupation : ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      for (var i = 0; i < widget.occupation.length; i++)
                        Text(
                          "${i + 1}. \t ${widget.occupation[i]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )
                    ],
                  ),
                ),
              );
            });
      },
      child: Container(
        margin: EdgeInsets.all(5),
        child: Card(
          elevation: 5,
          child: Stack(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: widget.imageURL,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: 200,
                  height: 35,
                  color: Colors.black54,
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    widget.characterName,
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
        ),
      ),
    );
  }
}
