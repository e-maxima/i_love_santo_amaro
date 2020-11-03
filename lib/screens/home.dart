import 'package:ILoveSantoAmaro/helpers/common.dart';
import 'package:ILoveSantoAmaro/helpers/style.dart';
import 'package:ILoveSantoAmaro/provider/product.dart';
import 'package:ILoveSantoAmaro/provider/user.dart';
import 'package:ILoveSantoAmaro/screens/login.dart';
import 'package:ILoveSantoAmaro/screens/product_search.dart';
//import 'package:ILoveSantoAmaro/services/product.dart';
import 'package:ILoveSantoAmaro/widgets/custom_text.dart';
import 'package:ILoveSantoAmaro/widgets/featured_products.dart';
import 'package:ILoveSantoAmaro/widgets/product_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:ILoveSantoAmaro/widgets/search.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

import 'cart.dart';
import 'order.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _key = GlobalKey<ScaffoldState>();
  //ProductServices _productServices = ProductServices();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    int i;
    String firstName = '';
    for (i = 0; i < userProvider.userModel.name.length; i++) {
      if (userProvider.userModel.name[i] != ' ') {
        firstName = firstName + userProvider.userModel.name[i];
      } else {
        firstName = ' ' + firstName + ' ';
        break;
      }
    }
    print(firstName);
    return Scaffold(
      key: _key,
      backgroundColor: white,
      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: black),
              accountName: CustomText(
                text: userProvider.userModel?.name ?? "carregando usuário...",
                color: white,
                weight: FontWeight.bold,
                size: 18,
              ),
              accountEmail: CustomText(
                text: userProvider.userModel?.email ?? "carregando email...",
                color: white,
              ),
            ),
            ListTile(
              onTap: () async {
                changeScreen(context, CartScreen());
              },
              leading: Icon(Icons.shopping_cart),
              title: CustomText(text: "Meu carrinho"),
            ),
            ListTile(
              onTap: () async {
                await userProvider.getOrders();
                changeScreen(context, OrdersScreen());
              },
              leading: Icon(Icons.bookmark_border),
              title: CustomText(text: "Meus pedidos"),
            ),
            ListTile(
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login()));
                });
              },
              leading: Icon(Icons.exit_to_app),
              title: CustomText(text: "Sair"),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Positioned(
                  top: 10,
                  right: 20,
                  child: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                          onTap: () {
                            _key.currentState.openEndDrawer();
                          },
                          child: Icon(Icons.menu))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Olá' + firstName + 'qual\nproduto está procurando? ',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black.withOpacity(0.6),
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 8, left: 8, right: 8, bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.search,
                      color: black,
                    ),
                    title: TextField(
                      textInputAction: TextInputAction.search,
                      onSubmitted: (pattern) async {
                        await productProvider.search(productName: pattern);
                        changeScreen(context, ProductSearchScreen());
                      },
                      decoration: InputDecoration(
                        hintText: "artesanato, vestido...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: new Text('Destaques')),
                ),
              ],
            ),
            FeaturedProducts(),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: new Text('Últimos pesquisados')),
                ),
              ],
            ),
            Column(
              children: productProvider.products
                  .map((item) => GestureDetector(
                        child: ProductCard(
                          product: item,
                        ),
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
