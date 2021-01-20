import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flmyapp/model/user.dart';
import 'package:flutter/cupertino.dart';

class UserStore with ChangeNotifier {
  User _user;

  Future<void> getUserData() async {
    String url = 'http://10.0.2.2:8000/api/user/';
    try {
      http.Response response = await http.get(url, headers: {
        "Authorization": 'token e3acc112ff6391eec4202259719339b61bd79200'
      });
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
        print(newUser);
        _user = newUser;
      }
    } catch (e) {
      print(e);
    }
  }

  User get user {
    return _user;
  }
}
