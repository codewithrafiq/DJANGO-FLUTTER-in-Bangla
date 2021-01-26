import 'package:flmyapp/screens/cart_screens.dart';
import 'package:flmyapp/store/cart_store.dart';
import 'package:flmyapp/store/product_store.dart';
import 'package:flmyapp/store/user_store.dart';
import 'package:flmyapp/widgets/drower_app.dart';
import 'package:flmyapp/widgets/single_Product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreens extends StatefulWidget {
  @override
  _HomeScreensState createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  bool _init = true;

  @override
  void didChangeDependencies() {
    if (_init) {
      Provider.of<ProductStore>(context, listen: false).getProductsData();
      Provider.of<UserStore>(context, listen: false).getUserData();
      Provider.of<CartStore>(context, listen: false).getCartDatas();
      Provider.of<CartStore>(context, listen: false).getCartProductsDatas();
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductStore>(context).products;
    final cartProducts = Provider.of<CartStore>(context).cartproducts;
    return Scaffold(
      drawer: DrowerApp(),
      appBar: AppBar(
        title: Text("Welcome to My Shop"),
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
              "${cartProducts != null ? cartProducts.length : ''}",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: products.length,
        itemBuilder: (ctx, i) {
          var data = products[i];
          return SingleProduct(
            id: data.id,
            title: data.title,
            image: data.image,
            favorit: data.favorit,
          );
        },
      ),
    );
  }
}
