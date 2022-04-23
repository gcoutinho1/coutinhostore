import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coutinhostore/datas/product_data.dart';

class CartProduct {
  String cartId;
  String category;
  String productId;
  int quantity;
  String size;

  ProductData productData;


  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot documentSnapshot) {
    cartId = documentSnapshot.documentID;
    category = documentSnapshot.data["category"];
    productId = documentSnapshot.data["productId"];
    quantity = documentSnapshot.data["quantity"];
    size = documentSnapshot.data["size"];

  }

  Map<String, dynamic> toMap(){
    return{
      "category" : category,
      "productId" : productId,
      "quantity" : quantity,
      "size" : size,
      "product" : productData.toResumedMap()

    };
  }


}