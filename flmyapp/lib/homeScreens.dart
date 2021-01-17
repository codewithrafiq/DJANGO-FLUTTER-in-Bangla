import 'package:flmyapp/add_edit_Screens.dart';
import 'package:flmyapp/globalstate/globalState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreens extends StatefulWidget {
  @override
  _HomeScreensState createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  @override
  void didChangeDependencies() {
    Provider.of<GState>(context, listen: false).getTodsData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDo App"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddEditScreens.routeName);
            },
          )
        ],
      ),
    );
  }
}
