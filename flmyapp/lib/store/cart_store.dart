import 'dart:convert';

import 'package:flmyapp/model/Product.dart';
import 'package:flmyapp/model/cart.dart';
import 'package:flmyapp/model/cartproduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;

class CartStore with ChangeNotifier {
  CartModel _cartModel;
  List<CartProduct> _cartproduct;

  LocalStorage storage = LocalStorage("userdata");

  Future<void> getCartDatas() async {
    String url = 'http://10.0.2.2:8000/api/cart/';
    var token = storage.getItem('mytoken');
    try {
      http.Response response = await http.get(url, headers: {
        "Authorization": "token $token",
      });
      var data = json.decode(response.body);

      CartModel cartModel = CartModel(
        id: data['id'],
        date: data["date"],
        total: data["total"],
      );
      _cartModel = cartModel;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getCartProductsDatas() async {
    String url = 'http://10.0.2.2:8000/api/cartproduct/';
    var token = storage.getItem('mytoken');
    try {
      http.Response response = await http.get(url, headers: {
        "Authorization": "token $token",
      });
      var data = json.decode(response.body) as List;
      List<CartProduct> _temp = [];
      data.forEach((element) {
        CartProduct tempcp = CartProduct(
          id: element['id'],
          price: element['price'],
          quantity: element['quantity'],
          subtotal: element['subtotal'],
          product: Product(
            id: element['product']["id"],
            title: element['product']["title"],
          ),
        );
        _temp.add(tempcp);
      });
      _cartproduct = _temp;
    } catch (e) {
      print(e);
    }
  }

  CartModel get cart {
    if (_cartModel != null) {
      return _cartModel;
    }
    return null;
  }

  List<CartProduct> get cartproducts {
    if (_cartproduct != null) {
      return [..._cartproduct];
    }
    return null;
  }

  Future<void> addToCart(int id) async {
    String url = 'http://10.0.2.2:8000/api/addtocart/';
    var token = storage.getItem('mytoken');
    try {
      http.Response response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "token $token"
        },
        body: json.encode({
          "id": id,
        }),
      );
      var data = json.decode(response.body) as Map;
      print(data["error"]);
      if (data["error"] == false) {
        getCartProductsDatas();
        notifyListeners();
      }
    } catch (e) {}
  }
}
