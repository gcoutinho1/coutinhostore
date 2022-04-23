import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceTile extends StatelessWidget {
  final DocumentSnapshot snapshot;

  PlaceTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 100,
            child: Image.network(
              snapshot.data["image"],
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(snapshot.data["title"],
                    textAlign: TextAlign.start,
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                Text(snapshot.data["adress"],
                    textAlign: TextAlign.start,
                    style:
                    TextStyle(fontWeight: FontWeight.w300, fontSize: 17)),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
//            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text("Ver Localização"),
                textColor: Theme.of(context).primaryColor,
                padding: EdgeInsets.zero,
                onPressed: () {
                  launch(
                      "https://www.google.com/maps/search/?api=1&query=${snapshot.data["lat"]},"
                          "${snapshot.data["long"]}");
                },
              ),
              FlatButton(
                child: Text("Ligar na loja"),
                textColor: Theme.of(context).primaryColor,
                padding: EdgeInsets.zero,
                onPressed: () {
                  launch("tel:${snapshot.data["phone"]}");
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}