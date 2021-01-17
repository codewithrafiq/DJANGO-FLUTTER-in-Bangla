import 'package:flmyapp/add_data.dart';
import 'package:flmyapp/gstore/gloabal_state.dart';
import 'package:provider/provider.dart';

import './homeScreens.dart';
import 'package:flutter/material.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => GState(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (ctx) => HomeScreens(),
          AddData.routeName: (ctx) => AddData(),
        },
      ),
    );
  }
}
