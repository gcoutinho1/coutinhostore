import 'package:coutinhostore/models/cart_model.dart';
import 'package:coutinhostore/models/user_model.dart';
import 'package:coutinhostore/tiles/cart_tile.dart';
import 'package:coutinhostore/widgets/cart_price.dart';
import 'package:coutinhostore/widgets/discount_card.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'login_screen.dart';
import 'order_screen.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu carrinho"),
        centerTitle: true,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
                builder: (context, child, model) {
                  int p = model.products.length;
                  //alterar para itens se o produto for acima de 1
                  return Text(
                    "${p ?? 0} ${p == 1 ? "Item" : "Itens"}",
                    style: TextStyle(fontSize: 16),
                  );
                }),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if (model.isLoading && UserModel.of(context).isLoggedIn()) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!UserModel.of(context).isLoggedIn()) {
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.remove_shopping_cart,
                    size: 80,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Faça Login para adicionar os produtos!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  RaisedButton(
                    child: Text(
                      "Entrar",
                      style: TextStyle(fontSize: 15),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    },
                  ),
                ],
              ),
            );
          } else if (model.products == null || model.products.length == 0) {
            return Center(
              child: Text(
                "Nenhum produto no carrinho",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return ListView(
              children: <Widget>[
                Column(
                  children: model.products
                      .map((product) => CartTile(product))
                      .toList(),
                ),
                DiscountCard(),
                CartPrice(() async {
                  String orderId = await model.finishOrder();
                  if (orderId != null)
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => OrderScreen(orderId)));
                }),
              ],
            );
          }
        },
      ),
    );
  }
}
