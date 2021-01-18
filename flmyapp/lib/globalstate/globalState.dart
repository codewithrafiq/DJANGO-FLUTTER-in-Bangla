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

  List<Todo> get todos {
    return [..._todos];
  }

  Future<void> addNewTodo(String ntitle) async {
    try {
      http.Response response = await http.post(
        urls,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "title": ntitle,
        }),
      );
      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteTodo(int id) async {
    String ur = 'http://10.0.2.2:8000/api/todo/$id/';
    try {
      http.Response response = await http.delete(ur);
      if (response.statusCode > 400) {
        print("data not delated");
      } else {
        print(response.body);
        print("Data");
      }
    } catch (e) {
      print("Data not Delated");
    }
  }

  Todo singleTodo(int id) {
    return _todos.firstWhere((element) => element.id == id);
  }

  Future<void> updateTodo(int id, String title) async {
    String ur = 'http://10.0.2.2:8000/api/todo/$id/';
    try {
      http.Response response = await http.put(
        ur,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "title": title,
        }),
      );
      print(response.body);
      print("data is updated");
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
