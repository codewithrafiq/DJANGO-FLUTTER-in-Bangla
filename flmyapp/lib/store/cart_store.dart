import 'dart:convert';

import 'package:flmyapp/model/Product.dart';
import 'package:flmyapp/model/cart.dart';
import 'package:flmyapp/model/cartproduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;

class CartStore with ChangeNotifier {
  LocalStorage storage = LocalStorage("userdata");

  List<Cart> _cart = [];

  Future<void> getCartDatas() async {
    String url = 'http://10.0.2.2:8000/api/cart/';
    var token = storage.getItem('mytoken');
    try {
      http.Response response = await http.get(url, headers: {
        "Authorization": "token $token",
      });

      print(response.body);
    } catch (e) {}
  }
}
