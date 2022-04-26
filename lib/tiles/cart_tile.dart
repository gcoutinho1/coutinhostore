import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coutinhostore/datas/cart_product.dart';
import 'package:coutinhostore/datas/product_data.dart';
import 'package:coutinhostore/models/cart_model.dart';
import 'package:flutter/material.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;

  CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {
      CartModel.of(context).updatePrices();
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            width: 120,
            child: Image.network(
              cartProduct.productData.images[0],
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(cartProduct.productData.title,
                      style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),
                  Text("Tamanho: ${cartProduct.size}",
                      style:
                      TextStyle(fontWeight: FontWeight.w300, fontSize: 17)),
                  Text(
                      "R\$ ${cartProduct.productData.price.toStringAsFixed(2)}",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.remove),
                        color: Colors.redAccent,
                        onPressed: cartProduct.quantity > 1
                            ? () {
                          CartModel.of(context)
                              .decrementProduct(cartProduct);
                        }
                            : null,
                      ),
                      Text(cartProduct.quantity.toString()),
                      IconButton(
                          icon: Icon(Icons.add),
                          color: Colors.green,
                          onPressed: () {
                            CartModel.of(context).incrementProduct(cartProduct);

                          }),
                      //TODO: change to textButton
                      FlatButton(
                        onPressed: () {
                          CartModel.of(context).removeCartItem(cartProduct);
                        },
                        child: Text(
                          "Remover item",
                          textAlign: TextAlign.center,
                        ),
                        textColor: Colors.grey[500],
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    return Card(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: cartProduct.productData == null
            ? FutureBuilder<DocumentSnapshot>(
          future: Firestore.instance
              .collection("products")
              .document(cartProduct.category)
              .collection("items")
              .document(cartProduct.productId)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              cartProduct.productData =
                  ProductData.fromDocument(snapshot.data);
              return _buildContent();
            } else {
              return Container(
                height: 70,
                child: CircularProgressIndicator(),
                alignment: Alignment.center,
              );
            }
          },
        )
            : _buildContent());
  }
}