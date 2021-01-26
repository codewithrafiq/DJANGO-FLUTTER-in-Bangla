import 'package:flmyapp/store/cart_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreens extends StatelessWidget {
  static const routeName = '/cart-screens';
  @override
  Widget build(BuildContext context) {
    final cartState = Provider.of<CartStore>(context);
    final cart = cartState.cart;
    final cartProducts = cartState.cartproducts;
    if ((cart == null) || (cartProducts == null))
      return Scaffold(
        body: Center(
          child: Text(
            "No Cart",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
      );
    else
      return Scaffold(
        appBar: AppBar(
          title: Text("My Cart"),
        ),
        body: Padding(
          padding: EdgeInsets.all(6),
          child: ListView.builder(
            itemCount: cartProducts.length + 1,
            itemBuilder: (ctx, i) {
              if (i == 0) {
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Total : "),
                        Text("${cart.total}"),
                        Text("Date: "),
                        Text("${cart.date} ")
                      ],
                    ),
                  ),
                );
              }
              var item = cartProducts[i - 1];
              return Card(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(item.product.title),
                          Text("Price: ${item.price}"),
                          Text("Quantity: ${item.quantity}"),
                          Text("Subtotal: ${item.subtotal}"),
                        ],
                      ),
                      RaisedButton(
                        color: Colors.red,
                        onPressed: () {},
                        child: Text(
                          "Delate",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
  }
}
