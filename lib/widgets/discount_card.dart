import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coutinhostore/models/cart_model.dart';
import 'package:flutter/material.dart';

class DiscountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
      child: ExpansionTile(
        title: Text("Cupom de desconto",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[800]
          ),
        ),
        leading: Icon(Icons.card_giftcard),
//            trailing: Icon(Icons.add),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Digite seu cupom"
              ),
              initialValue: CartModel.of(context).discountCode ?? "",
              onFieldSubmitted: (text){
                Firestore.instance.collection("coupons").document(text).get().then((docSnap){
                  if(docSnap.data != null){
                    CartModel.of(context).setCoupon(text, docSnap.data["percent"]);
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Desconto de ${docSnap.data["percent"]}% aplicado"),
                          backgroundColor: Theme.of(context).primaryColor,
                          duration: Duration(seconds: 1),
                        )
                    );
                  }else{
                    CartModel.of(context).setCoupon(null, 0);
                    Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text("Cupom inválido"),
                        backgroundColor: Colors.redAccent,
                        duration: Duration(seconds: 1),
                      ),
                    );

                  }
                });
              },
            ),
          )
        ],
      ),

    );
  }
}