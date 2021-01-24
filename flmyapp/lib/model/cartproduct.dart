import 'package:flmyapp/model/Product.dart';

class CartProduct {
  final int id;
  final int price;
  int quantity;
  int subtotal;
  final Product product;

  CartProduct({
    this.id,
    this.price,
    this.quantity,
    this.subtotal,
    this.product,
  });
}
