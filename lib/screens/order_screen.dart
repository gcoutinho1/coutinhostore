import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  final String orderId;

  OrderScreen(this.orderId);

  @override
  Widget _buildOrderBack() => Container(
    //TODO: change this UI, it's ugly now
    decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color.fromARGB(255, 203, 236, 241), Colors.redAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter)),
  );
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildOrderBack(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("Pedido concluido"),
            centerTitle: true,
          ),
          body: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.check,
                  color: Theme.of(context).primaryColor,
                  size: 80,
                ),
                Text("Pedido realizado com sucesso",
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    textAlign: TextAlign.center),
                Text(
                  "Codigo do pedido:",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "$orderId",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.redAccent,
                      backgroundColor: Theme.of(context).primaryColor),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}