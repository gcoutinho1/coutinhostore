import 'package:coutinhostore/models/cart_model.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPrice extends StatelessWidget {
  final VoidCallback buy;

  CartPrice(this.buy);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Container(
          padding: EdgeInsets.all(16),
          child: ScopedModelDescendant<CartModel>(
            builder: (context, child, model) {
              double price = model.getProductsPrice();
              double discount = model.getDiscount();
              double ship = model.getShipPrice();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Resumo do pedido",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Subtotal"),
                      Text("R\$ ${price.toStringAsFixed(2)}")
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Desconto"),
                      Text("R\$ ${discount.toStringAsFixed(2)}")
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Entrega"),
                      Text("R\$ ${ship.toStringAsFixed(2)}")
                    ],
                  ),
                  Divider(),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Total",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "R\$ ${(price + ship - discount).toStringAsFixed(2)}",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  RaisedButton(
                    child: Text("Finalizar pedido"),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: buy,
                  )
                ],
              );
            },
          ),
        ));
  }
}