import 'package:flmyapp/screens/cart_screens.dart';
import 'package:flmyapp/screens/home_screens.dart';
import 'package:flmyapp/screens/login_screens.dart';
import 'package:flmyapp/screens/product_details_screens.dart';
import 'package:flmyapp/screens/profile_screens.dart';
import 'package:flmyapp/screens/register_screens.dart';
import 'package:flmyapp/store/cart_store.dart';
import 'package:flmyapp/store/product_store.dart';
import 'package:flmyapp/store/user_store.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LocalStorage storage = LocalStorage("userdata");
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ProductStore()),
        ChangeNotifierProvider(create: (ctx) => UserStore()),
        ChangeNotifierProvider(create: (ctx) => CartStore()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: storage.ready,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (storage.getItem('mytoken') == null) {
              return LoginScreens();
            }
            return HomeScreens();
          },
        ),
        routes: {
          '/home': (ctx) => HomeScreens(),
          ProductDetailsScreens.routeName: (ctx) => ProductDetailsScreens(),
          ProfileScreens.routeName: (ctx) => ProfileScreens(),
          LoginScreens.routeName: (ctx) => LoginScreens(),
          RegisterScreens.routeName: (ctx) => RegisterScreens(),
          CartScreens.routeName: (ctx) => CartScreens(),
        },
      ),
    );
  }
}
