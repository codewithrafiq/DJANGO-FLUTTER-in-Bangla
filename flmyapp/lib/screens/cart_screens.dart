import 'package:flmyapp/model/cartproduct.dart';
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
                child: Column(
                  children: [
                    Text("${item.product.title}"),
                    Text("Price: ${item.price}"),
                    Text("Quantity: ${item.quantity}"),
                    Text("Subtotal: ${item.subtotal}"),
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
