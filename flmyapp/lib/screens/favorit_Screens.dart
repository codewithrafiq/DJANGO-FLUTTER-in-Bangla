import 'package:flmyapp/store/product_store.dart';
import 'package:flmyapp/widgets/drower_app.dart';
import 'package:flmyapp/widgets/single_Product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritScreens extends StatelessWidget {
  static const routeName = '/favorit-screens';
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductStore>(context).favorites;
    return Scaffold(
      drawer: DrowerApp(),
      appBar: AppBar(
        title: Text("Favorites"),
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
