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
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductStore>(context).products;
    return Scaffold(
      drawer: DrowerApp(),
      appBar: AppBar(
        title: Text("Welcome to My Shop"),
        actions: [],
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
          );
        },
      ),
    );
  }
}
