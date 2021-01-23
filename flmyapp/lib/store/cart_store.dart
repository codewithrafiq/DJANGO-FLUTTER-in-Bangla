import 'dart:convert';

import 'package:flmyapp/model/Product.dart';
import 'package:flmyapp/model/cart.dart';
import 'package:flmyapp/model/cartproduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;

class CartStore with ChangeNotifier {
  List _data = [];

  LocalStorage storage = LocalStorage("userdata");

  Future<void> getCartDatas() async {
    String url = 'http://10.0.2.2:8000/api/cart/';
    var token = storage.getItem('mytoken');
    try {
      http.Response response = await http.get(url, headers: {
        "Authorization": "token $token",
      });
      var responsdata = json.decode(response.body) as List;
      _data = responsdata;
      _cartModel();
      _cartProduct();
    } catch (e) {}
  }

  CartModel _cartModel() => CartModel(
        id: _data[0]["id"],
        date: _data[0]["date"],
        total: _data[0]['total'],
      );

  List<CartProduct> _cartProduct() {
    List<CartProduct> temp = [];
    var cartprod = _data[0]['cartproducts'] as List;
    cartprod.forEach((element) {
      CartProduct cartProduct = CartProduct(
        id: element["id"],
        price: element["price"],
        quantity: element["quantity"],
        subtotal: element['subtotal'],
        product: Product(
          id: element['product'][0]["id"],
          title: element['product'][0]["title"],
          sprice: element['product'][0]["selling_price"],
          mprice: element['product'][0]["marcket_price"],
          image: element['product'][0]["image"],
          description: element['product'][0]["description"],
          date: element['product'][0]["data"],
          category: null,
        ),
      );
      temp.add(cartProduct);
    });
    return temp;
  }

  CartModel get cart {
    return _cartModel();
  }

  List<CartProduct> get cartproducts {
    return [..._cartProduct()];
  }
}
