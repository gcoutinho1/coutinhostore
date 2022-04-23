import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {

  String category;
  String id;
  String title;
  String description;
  double price;
  List sizes;
  List images;

  ProductData.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.documentID;
    title = snapshot.data["title"];
    description = snapshot.data["description"];
    price = snapshot.data["price"];
    sizes = snapshot.data["sizes"];
    images = snapshot.data["images"];
  }

  Map<String, dynamic> toResumedMap(){
    return {
      "title" : title,
      "description" : description,
      "price" : price
    };
  }

}