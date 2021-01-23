import 'package:flmyapp/screens/product_details_screens.dart';
import 'package:flmyapp/store/product_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleProduct extends StatelessWidget {
  final int id;
  final String title;
  final String image;
  final bool favorit;
  SingleProduct({
    this.id,
    this.title,
    this.image,
    this.favorit,
  });
  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            ProductDetailsScreens.routeName,
            arguments: id,
          );
        },
        child: Image.network(
          "http://10.0.2.2:8000$image",
          fit: BoxFit.cover,
        ),
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        leading: IconButton(
          icon: Icon(
            favorit ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
          ),
          onPressed: () {
            Provider.of<ProductStore>(context, listen: false).makeFavorit(id);
          },
        ),
        title: Text(title),
      ),
    );
  }
}
