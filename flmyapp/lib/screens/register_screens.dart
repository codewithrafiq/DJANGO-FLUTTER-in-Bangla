import 'package:flmyapp/screens/login_screens.dart';
import 'package:flmyapp/store/user_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreens extends StatefulWidget {
  static const routeName = '/register-screens';
  @override
  _RegisterScreensState createState() => _RegisterScreensState();
}

class _RegisterScreensState extends State<RegisterScreens> {
  final _form = GlobalKey<FormState>();
  String username;
  String password1;
  String password2;
  void _registerNow() async {
    var isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();

    bool response = await Provider.of<UserStore>(context, listen: false)
        .registerNow(username, password2);

    if (response) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Sonmthing is Wrong! Try Agane!"),
            actions: [
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Ok"),
              )
            ],
          );
        },
      );
    } else {
      Navigator.of(context).pushReplacementNamed(LoginScreens.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Now"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  validator: (v) {
                    if (v.isEmpty) {
                      return 'Enter a username';
                    }
                    return null;
                  },
                  onSaved: (v) {
                    username = v;
                  },
                  decoration: InputDecoration(hintText: "Enter a Username"),
                ),
                TextFormField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  validator: (v) {
                    if (v.isEmpty) {
                      return 'Enter a Password';
                    }
                    if (v.length < 8) {
                      return 'Password must be 8 characters';
                    }
                    return null;
                  },
                  onChanged: (v) {
                    setState(() {
                      password1 = v;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Password",
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  validator: (v) {
                    if (v.isEmpty) {
                      return 'Confirm Password';
                    }
                    if (password1 != v) {
                      return 'Password not Matched';
                    }
                    return null;
                  },
                  onSaved: (v) {
                    password2 = v;
                  },
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        _registerNow();
                      },
                      child: Text("Register"),
                      color: Colors.red,
                    ),
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(LoginScreens.routeName);
                        },
                        child: Text(
                          "Login Now",
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
