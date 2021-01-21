import 'dart:convert';

import 'package:flmyapp/model/Category.dart';
import 'package:flmyapp/model/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class ProductStore with ChangeNotifier {
  LocalStorage storage = LocalStorage("userdata");
  List<Product> _products = [];

  Future<void> getProductsData() async {
    String url = 'http://10.0.2.2:8000/api/products/';
    var token = storage.getItem('mytoken');
    try {
      http.Response response = await http.get(
        url,
        headers: {"Authorization": "token $token"},
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body) as List;
        List<Product> newList = [];
        data.forEach((element) {
          Product newProduct = Product(
            id: element['id'],
            title: element['title'],
            date: element['data'],
            image: element['image'],
            mprice: element['marcket_price'],
            sprice: element['selling_price'],
            description: element['description'],
            category: Category(
              id: element['category']['id'],
              title: element['category']['title'],
              date: element['category']['date'],
            ),
          );
          newList.add(newProduct);
        });
        _products = newList;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  List<Product> get products {
    return [..._products];
  }

  Product singleProduct(int id) {
    return _products.firstWhere((element) => element.id == id);
  }
}
