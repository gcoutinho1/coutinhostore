import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coutinhostore/models/user_model.dart';
import 'package:coutinhostore/screens/login_screen.dart';
import 'package:coutinhostore/tiles/order_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (UserModel.of(context).isLoggedIn()) {
      String uid = UserModel.of(context).firebaseUser.uid;

      return FutureBuilder<QuerySnapshot>(
          future: Firestore.instance
              .collection("users")
              .document(uid)
              .collection("orders")
              .getDocuments(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            else {
              return ListView(
                children: snapshot.data.documents
                    .map((doc) => OrderTile(doc.documentID))
                    .toList()
                    .reversed
                    .toList(),
              );
            }
          });
    } else {
      return Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.view_list,
              size: 80,
              color: Colors.grey,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Faça Login para acompanhar os pedidos!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
              child: Text(
                "Entrar",
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    }
  }
}
