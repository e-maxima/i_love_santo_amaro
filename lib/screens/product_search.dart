import 'package:ILoveSantoAmaro/helpers/common.dart';
import 'package:ILoveSantoAmaro/helpers/style.dart';
import 'package:ILoveSantoAmaro/provider/product.dart';
import 'package:ILoveSantoAmaro/screens/cart.dart';
import 'package:ILoveSantoAmaro/screens/product_details.dart';
import 'package:ILoveSantoAmaro/widgets/custom_text.dart';
import 'package:ILoveSantoAmaro/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: CustomText(
          text: "Produtos",
          size: 20,
        ),
        elevation: 0.0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                changeScreen(context, CartScreen());
              })
        ],
      ),
      body: productProvider.productsSearched.length < 1
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      color: grey,
                      size: 30,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomText(
                      text: "Nenhum produto encontrado",
                      color: grey,
                      weight: FontWeight.w300,
                      size: 22,
                    ),
                  ],
                )
              ],
            )
          : ListView.builder(
              itemCount: productProvider.productsSearched.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () async {
                      changeScreen(
                          context,
                          ProductDetails(
                              product:
                                  productProvider.productsSearched[index]));
                    },
                    child: ProductCard(
                        product: productProvider.productsSearched[index]));
              }),
    );
  }
}
