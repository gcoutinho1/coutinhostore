import 'package:coutinhostore/screens/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'models/cart_model.dart';
import 'models/user_model.dart';

void main() {
  // if(!kIsWeb && debugDefaultTargetPlatformOverride == null) {
  //   debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  // }
  // print(debugDefaultTargetPlatformOverride);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
        model: UserModel(),
        child: ScopedModelDescendant<UserModel>(
            builder: (context, child, model){
              return ScopedModel<CartModel> (
                model: CartModel(model),
                child: MaterialApp(
                  title: "Coutinho Store",
                  theme: ThemeData(
                      // primarySwatch: Colors.red,
                      primaryColor: Colors.black,
                      brightness: Brightness.dark,
                      visualDensity: VisualDensity.adaptivePlatformDensity,
                  ),
                  // theme: ThemeData(
                  //   primarySwatch: Colors.blue,
                  //   // primaryColor: Color.fromARGB(255, 4, 125, 141),
                  //   primaryColor: Color.fromARGB(255, 100, 200, 100),
                  //   visualDensity: VisualDensity.adaptivePlatformDensity,
                  // ),
                  debugShowCheckedModeBanner: false,
                  home: HomeScreen(),
                ),
              );
            })
    );
  }
}