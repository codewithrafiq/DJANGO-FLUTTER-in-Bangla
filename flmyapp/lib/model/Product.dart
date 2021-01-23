import 'package:flmyapp/model/Category.dart';

class Product {
  final int id;
  final String title;
  final String date;
  final String image;
  final int mprice;
  final int sprice;
  final String description;
  final Category category;
  bool favorit;

  Product({
    this.id,
    this.title,
    this.date,
    this.image,
    this.mprice,
    this.sprice,
    this.description,
    this.category,
    this.favorit,
  });
}
