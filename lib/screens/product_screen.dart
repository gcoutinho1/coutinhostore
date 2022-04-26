import 'package:carousel_pro/carousel_pro.dart';
import 'package:coutinhostore/datas/cart_product.dart';
import 'package:coutinhostore/datas/product_data.dart';
import 'package:coutinhostore/models/cart_model.dart';
import 'package:coutinhostore/models/user_model.dart';
import 'package:flutter/material.dart';

import 'cart_screen.dart';
import 'login_screen.dart';

class ProductScreen extends StatefulWidget {
  final ProductData product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData product;
  String size;
  _ProductScreenState(this.product);
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: product.images.map((url) => NetworkImage(url)).toList(),
              dotSize: 4,
              dotSpacing: 10,
              dotBgColor: Colors.transparent,
              dotColor: Colors.redAccent,
              dotIncreasedColor: Colors.black,
//              autoplay: false,  alterar imgs automatico
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  product.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[700]),
                ),
                SizedBox(
                  height: 16,
                ),
                Text("Tamanho", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                SizedBox(height: 40,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.5,

                    ),
                    children: product.sizes.map((e) => GestureDetector(
                      onTap: (){
                        setState(() {
                          size = e;
                        });

                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: e == size ? Colors.blue[700] : Colors.grey[500])
                        ),
                        width: 50,
                        alignment: Alignment.center,
                        child: Text(e),
                      ),
                    )).toList(),
                  ),
                ),
                SizedBox(height: 16,),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    onPressed: size != null ? (){
                      if(UserModel.of(context).isLoggedIn()){
                        //add cart

                        CartProduct cartProduct = CartProduct();
                        cartProduct.size = size;
                        cartProduct.quantity = 1;
                        cartProduct.productId = product.id;
                        cartProduct.category = product.category;
                        cartProduct.productData = product;

                        CartModel.of(context).addCartItem(cartProduct);
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => CartScreen())
                        );

                      } else{
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => LoginScreen())
                        );
                      }
                    } : null,
                    child: Text(UserModel.of(context).isLoggedIn() ? "Adicionar ao carrinho" : "Faça login para comprar", style: TextStyle(fontSize: 18,),
                    ),
                    color: primaryColor,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                Text("Descrição", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)
                ),
                SizedBox(height: 16),
                Text(product.description, style: TextStyle(fontSize: 16)
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}