import 'package:coutinhostore/models/user_model.dart';
import 'package:coutinhostore/screens/login_screen.dart';
import 'package:coutinhostore/tiles/drawer_tile.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget _buildDrawerBack() => Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(colors: [

          Colors.white,
          Colors.white70,
          // Colors.white

        ],
            stops: [0.4, 0.8],
            begin: Alignment.topCenter, end: Alignment.bottomCenter)),
  );
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32, top: 15),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 9),
                padding: EdgeInsets.fromLTRB(0, 16, 16, 8),
                height: 170,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8,
                      left: 0,
                      child: (Text(
                        "Coutinho Store",
                        style: TextStyle(
                            fontSize: 34, fontWeight: FontWeight.bold, color: Colors.black),
                      )),
                    ),
                    Positioned(
                        left: 0,
                        bottom: 0,
                        child: ScopedModelDescendant<UserModel>(
                          builder: (context, child, model) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Olá, ${!model.isLoggedIn() ? "" : model.userData["name"]}",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                                GestureDetector(
                                  child: Text(
                                    !model.isLoggedIn()
                                        ? "Entre ou cadastre-se >"
                                        : "Sair",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onTap: () {
                                    if (!model.isLoggedIn())
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()));
                                    else
                                      model.signOut();
                                  },
                                ),
                              ],
                            );
                          },
                        ))
                  ],
                ),
              ),
//              Divider(),
              DrawerTile(Icons.home, "Inicio", pageController, 0),
              DrawerTile(Icons.list, "Produtos", pageController, 1),
              DrawerTile(Icons.location_on, "Lojas", pageController, 2),
              DrawerTile(
                  Icons.playlist_add_check, "Meus pedidos", pageController, 3),
            ],
          ),
        ],
      ),
    );
  }
}