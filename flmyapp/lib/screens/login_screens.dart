import 'package:flmyapp/screens/register_screens.dart';
import 'package:flmyapp/store/user_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreens extends StatefulWidget {
  static const routeName = '/login-screens';
  @override
  _LoginScreensState createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  @override
  Widget build(BuildContext context) {
    final _form = GlobalKey<FormState>();
    String username;
    String password;

    void _loginBytton() {
      var isValid = _form.currentState.validate();
      if (!isValid) {
        return;
      }
      _form.currentState.save();
      Provider.of<UserStore>(context, listen: false).liginNow(
        username,
        password,
      );
      print(username);
      print(password);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Login Now"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (v) {
                  if (v.isEmpty) {
                    return "Enter your username";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Enter Your Username",
                ),
                onSaved: (v) {
                  username = v;
                },
              ),
              TextFormField(
                validator: (v) {
                  if (v.isEmpty) {
                    return "Enter your password";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Enter Your Password",
                ),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                onSaved: (v) {
                  password = v;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    onPressed: () {
                      _loginBytton();
                    },
                    color: Colors.blue,
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(RegisterScreens.routeName);
                    },
                    child: Text("Register Now"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
