import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coutinhostore/datas/cart_product.dart';
import 'package:coutinhostore/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel userModel;

  List<CartProduct> products = [];
  bool isLoading = false;
  String discountCode;
  int discountPercentage = 0;


  CartModel(this.userModel) {
    if (userModel.isLoggedIn()) _loadCartItems();
  }

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);

    Firestore.instance
        .collection("users")
        .document(userModel.firebaseUser.uid)
        .collection("cart")
        .add(cartProduct.toMap())
        .then((doc) => cartProduct.cartId = doc.documentID);
    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) {
    products.remove(cartProduct);

    Firestore.instance
        .collection("users")
        .document(userModel.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.cartId)
        .delete();

    notifyListeners();
  }

  void incrementProduct(CartProduct cartProduct) {
    cartProduct.quantity++;
    Firestore.instance
        .collection("users")
        .document(userModel.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.cartId)
        .updateData(cartProduct.toMap());

    notifyListeners();
  }


  void decrementProduct(CartProduct cartProduct) {
    cartProduct.quantity--;
    Firestore.instance
        .collection("users")
        .document(userModel.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.cartId)
        .updateData(cartProduct.toMap());

    notifyListeners();
  }

  void _loadCartItems() async {
    QuerySnapshot query = await Firestore.instance
        .collection("users")
        .document(userModel.firebaseUser.uid)
        .collection("cart")
        .getDocuments();

    products =
        query.documents.map((doc) => CartProduct.fromDocument(doc)).toList();
    notifyListeners();
  }

  void setCoupon(String discountCode, int discountPercentage) {
    this.discountCode = discountCode;
    this.discountPercentage = discountPercentage;
  }

  double getProductsPrice() {
    double price = 0;
    for (CartProduct c in products) {
      if (c.productData != null) price += c.quantity * c.productData.price;
    }
    return price;
  }

  double getShipPrice() {
    return 14.99;
  }

  double getDiscount() {
    return getProductsPrice() * discountPercentage / 100;
  }

  void updatePrices() {
    notifyListeners();
  }

  Future<String> finishOrder() async {
    if (products.length == 0) return null;
    isLoading = true;
    notifyListeners();

    double productsPrice = getProductsPrice();
    double shipPrice = getShipPrice();
    double discount = getDiscount();

    DocumentReference refOrder =
    await Firestore.instance.collection("orders").add({
      "clientId": userModel.firebaseUser.uid,
      "products": products.map((cartProduct) => cartProduct.toMap()).toList(),
      "shipPrice": shipPrice,
      "productsPrice": productsPrice,
      "discount": discount,
      "totalPrice": productsPrice - discount + shipPrice,
      "status": 1
    });

    await Firestore.instance
        .collection("users")
        .document(userModel.firebaseUser.uid)
        .collection("orders")
        .document(refOrder.documentID)
        .setData({"orderId": refOrder.documentID});

    QuerySnapshot querySnapshot = await Firestore.instance
        .collection("users")
        .document(userModel.firebaseUser.uid)
        .collection("cart")
        .getDocuments();

    for (DocumentSnapshot documentSnapshot in querySnapshot.documents) {
      documentSnapshot.reference.delete();
    }

    products.clear();
    discountPercentage = 0;
    discountCode = null;

    isLoading = false;
    notifyListeners();

    return refOrder.documentID;
  }
}