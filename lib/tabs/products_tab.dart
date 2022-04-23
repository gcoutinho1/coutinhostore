import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coutinhostore/tiles/category_tile.dart';
import 'package:flutter/material.dart';

class ProductsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance
            .collection("products")
            .orderBy("title")
            .getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            var dividedTiles = ListTile.divideTiles(
                tiles:
                snapshot.data.documents.map((doc) => CategoryTile(doc)),
                color: Colors.grey[600])
                .toList();
            return ListView(
              children: dividedTiles,
            );
          }
        });
  }
}