import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coutinhostore/tiles/place_tile.dart';
import 'package:flutter/material.dart';

class PlacesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("places").getDocuments(),
      builder: (context, snapshot){
        if(!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        else return ListView(
          children: snapshot.data.documents.map((doc) => PlaceTile(doc)).toList().reversed.toList(),
        );
      },
    );
  }
}