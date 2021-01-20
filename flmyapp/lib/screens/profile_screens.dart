import 'package:flmyapp/store/user_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreens extends StatelessWidget {
  static const routeName = '/profile-screens';
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserStore>(context).user;
    // print(user);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: ListView(
        children: [
          Text(user.id.toString()),
          Text(user.username),
          Text(user.firstName),
          Text(user.lastName),
          Text(user.email),
        ],
      ),
    );
  }
}
