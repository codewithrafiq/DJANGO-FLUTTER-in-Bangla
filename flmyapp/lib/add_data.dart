import 'package:flmyapp/gstore/gloabal_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddData extends StatefulWidget {
  static const routeName = '/add-screens';
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final _textControler = TextEditingController();

  void _addaData() {
    if (_textControler.text.length <= 0) {
      return;
    }
    Provider.of<GState>(context, listen: false).addData(
      _textControler.text,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Data"),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _textControler,
              decoration: InputDecoration(
                hintText: "Add A Data",
              ),
            ),
            RaisedButton(
              onPressed: () {
                _addaData();
              },
              child: Text("Add data"),
            ),
          ],
        ),
      ),
    );
  }
}
