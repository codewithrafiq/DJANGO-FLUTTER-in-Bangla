import 'package:flmyapp/screens/product_details_screens.dart';
import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final int id;
  final String title;
  final String image;
  SingleProduct({
    this.id,
    this.title,
    this.image,
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
          image,
          fit: BoxFit.cover,
        ),
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        leading: IconButton(
          icon: Icon(
            Icons.favorite_border,
            color: Colors.red,
          ),
          onPressed: () {},
        ),
        title: Text(title),
      ),
    );
  }
}
