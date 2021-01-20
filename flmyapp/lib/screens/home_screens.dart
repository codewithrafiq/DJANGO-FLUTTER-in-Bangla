import 'package:flmyapp/store/product_store.dart';
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
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductStore>(context).products;
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to My Shop"),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (ctx, i) {
            var data = products[i];
            return Column(
              children: [
                Text(data.title),
                Text(data.category.title),
              ],
            );
          },
        ),
      ),
    );
  }
}
