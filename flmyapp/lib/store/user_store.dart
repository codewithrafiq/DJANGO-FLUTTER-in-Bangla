import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flmyapp/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';

class UserStore with ChangeNotifier {
  LocalStorage storage = LocalStorage("userdata");

  User _user;

  Future<void> getUserData() async {
    String url = 'http://10.0.2.2:8000/api/user/';
    var token = storage.getItem('mytoken');
    try {
      http.Response response =
          await http.get(url, headers: {"Authorization": 'token $token'});
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        // print(data["id"]);
        User newUser = User(
          id: data['id'],
          username: data['username'],
          firstName: data['first_name'],
          lastName: data['last_name'],
          email: data['email'],
        );
        // print(newUser);
        _user = newUser;
      }
    } catch (e) {
      print(e);
    }
  }

  User get user {
    return _user;
  }

  Future<bool> liginNow(String username, String password) async {
    String url = 'http://10.0.2.2:8000/api/login/';
    try {
      http.Response response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {
            'username': username,
            'password': password,
          },
        ),
      );
      var data = json.decode(response.body) as Map<String, dynamic>;
      if (!data.containsKey('token')) {
        return false;
      }
      storage.setItem('mytoken', data['token']);
      print(response.body);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> registerNow(String username, String password) async {
    String url = 'http://10.0.2.2:8000/api/register/';
    try {
      http.Response response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {
            'username': username,
            'password': password,
          },
        ),
      );
      var data = json.decode(response.body) as Map<String, dynamic>;
      print(data["error"]);
      return data["error"];
    } catch (e) {
      print(e);
      return true;
    }
  }
}
