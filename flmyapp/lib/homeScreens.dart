import 'dart:convert';
import 'dart:html';

import 'package:flmyapp/add_data.dart';
import 'package:flmyapp/gstore/gloabal_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

class HomeScreens extends StatefulWidget {
  @override
  _HomeScreensState createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  // Future<void> getdata() async {
  //   String url = 'https://jsonplaceholder.typicode.com/posts';
  //  await http.get(url).then((response) {
  //     var data = json.decode(response.body);
  //     print(data);
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

  List<dynamic> posts = [];

  Future<void> getdata() async {
    String url = 'https://jsonplaceholder.typicode.com/posts';
    http.Response response = await http.post(url,
        headers: {"content-Type": 'application/json'},
        body: json.encode({"title": "title"}));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        posts = data;
      });
      print(data);
    }
  }

  @override
  void didChangeDependencies() {
    getdata();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("G Store"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddData.routeName);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: posts.length,
          itemBuilder: (ctx, i) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text("${posts[i]['title']}"),
              ),
            );
          },
        ),
      ),
    );
  }
}
