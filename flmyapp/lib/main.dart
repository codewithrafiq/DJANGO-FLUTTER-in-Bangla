import 'package:flmyapp/screens/home_screens.dart';
import 'package:flmyapp/screens/login_screens.dart';
import 'package:flmyapp/screens/product_details_screens.dart';
import 'package:flmyapp/screens/profile_screens.dart';
import 'package:flmyapp/screens/register_screens.dart';
import 'package:flmyapp/store/product_store.dart';
import 'package:flmyapp/store/user_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductStore(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => UserStore(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreens(),
        routes: {
          'home': (ctx) => HomeScreens(),
          ProductDetailsScreens.routeName: (ctx) => ProductDetailsScreens(),
          ProfileScreens.routeName: (ctx) => ProfileScreens(),
          LoginScreens.routeName: (ctx) => LoginScreens(),
          RegisterScreens.routeName: (ctx) => RegisterScreens(),
        },
      ),
    );
  }
}
