import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Todo {
  final int id;
  final String title;
  Todo({
    this.id,
    this.title,
  });
}

class GState with ChangeNotifier {
  String urls = 'http://10.0.2.2:8000/api/todo/';

  List<Todo> _todos = [];

  Future<void> getTodsData() async {
    http.Response response = await http.get(urls);
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      List<Todo> getTodo = [];
      data.forEach((element) {
        Todo todo = Todo(
          id: element["id"],
          title: element['title'],
        );
        getTodo.add(todo);
      });
      _todos = getTodo;
      notifyListeners();
    } else {
      print("No Data Found");
    }
  }
}
