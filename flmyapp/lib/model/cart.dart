import 'package:flmyapp/model/cartproduct.dart';

class Cart {
  final int id;
  final int total;
  final bool isComplit;
  final String date;
  final List<CartProduct> cartproducts;

  Cart({
    this.id,
    this.total,
    this.isComplit,
    this.date,
    this.cartproducts,
  });
}
