import 'package:flutter/material.dart';

class AddEditScreens extends StatefulWidget {
  static const routeName = '/add-edit-screens';
  @override
  _AddEditScreensState createState() => _AddEditScreensState();
}

class _AddEditScreensState extends State<AddEditScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
      ),
    );
  }
}
