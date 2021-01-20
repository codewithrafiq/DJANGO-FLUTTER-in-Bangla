import 'package:flmyapp/screens/profile_screens.dart';
import 'package:flutter/material.dart';

class DrowerApp extends StatelessWidget {
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
            trailing: Icon(Icons.logout),
            title: Text("Logout"),
          ),
        ],
      ),
    );
  }
}
