import 'dart:convert';

import 'package:flmyapp/model/Category.dart';
import 'package:flmyapp/model/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProductStore with ChangeNotifier {
  List<Product> _products = [];

  Future<void> getProductsData() async {
    String url = 'http://10.0.2.2:8000/api/products/';
    try {
      http.Response response = await http.get(url, headers: {
        "Authorization": 'token 3e67df84f6bde1bdc5f89867ef6af8293c3658f7'
      });
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
