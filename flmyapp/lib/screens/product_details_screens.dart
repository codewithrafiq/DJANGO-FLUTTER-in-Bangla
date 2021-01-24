import 'package:flmyapp/screens/cart_screens.dart';
import 'package:flmyapp/store/cart_store.dart';
import 'package:flmyapp/store/product_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreens extends StatelessWidget {
  static const routeName = '/product-details-screens';
  @override
  Widget build(BuildContext context) {
    final prodId = ModalRoute.of(context).settings.arguments;
    final product = Provider.of<ProductStore>(context).singleProduct(prodId);
    final cartState = Provider.of<CartStore>(context);
    final cartProducts = cartState.cartproducts;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        actions: [
          FlatButton.icon(
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreens.routeName);
            },
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            label: Text(
              "${cartProducts.length}",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Builder(
        builder: (context) => ListView(
          children: [
            Image.network(
              "http://10.0.2.2:8000${product.image}",
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Marcket Proce : ${product.mprice}"),
                      Text("Selling Price : ${product.sprice}"),
                    ],
                  ),
                  RaisedButton.icon(
                    color: Colors.green,
                    onPressed: () {
                      cartState.addToCart(prodId);
                      Scaffold.of(context).hideCurrentSnackBar();
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Product added To Cart !"),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Add To Cart",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Descriptions: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  Text(product.description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
