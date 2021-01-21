import 'package:flmyapp/screens/login_screens.dart';
import 'package:flmyapp/screens/profile_screens.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class DrowerApp extends StatefulWidget {
  @override
  _DrowerAppState createState() => _DrowerAppState();
}

class _DrowerAppState extends State<DrowerApp> {
  LocalStorage storage = LocalStorage("userdata");
  logoutNew() async {
    await storage.clear();
    Navigator.of(context).pushReplacementNamed(LoginScreens.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("Welcome"),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(ProfileScreens.routeName);
            },
            trailing: Icon(
              Icons.supervised_user_circle,
              color: Colors.black,
            ),
            title: Text(
              "Profile",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          Spacer(),
          ListTile(
            onTap: () {
              logoutNew();
            },
            trailing: Icon(Icons.logout),
            title: Text("Logout"),
          ),
        ],
      ),
    );
  }
}
