import 'package:flmyapp/add_edit_Screens.dart';
import 'package:flmyapp/globalstate/globalState.dart';
import 'package:flmyapp/homeScreens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (ctx) => HomeScreens(),
          AddEditScreens.routeName: (ctx) => AddEditScreens(),
        },
      ),
    );
  }
}
