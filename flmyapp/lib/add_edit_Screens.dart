import 'package:flmyapp/globalstate/globalState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEditScreens extends StatefulWidget {
  static const routeName = '/add-edit-screens';

  final int id;
  AddEditScreens([this.id]);

  @override
  _AddEditScreensState createState() => _AddEditScreensState();
}

class _AddEditScreensState extends State<AddEditScreens> {
  final _textControler = TextEditingController();

  @override
  void didChangeDependencies() {
    if (widget.id != null) {
      Todo oldTdo =
          Provider.of<GState>(context, listen: false).singleTodo(widget.id);
      _textControler.text = oldTdo.title;
    }
    super.didChangeDependencies();
  }

  void _addTodo() {
    if (_textControler.text.length <= 6) {
      return;
    }
    // print(_textControler.text);
    if (widget.id != null) {
      Provider.of<GState>(context, listen: false)
          .updateTodo(widget.id, _textControler.text);
    } else {
      Provider.of<GState>(context, listen: false)
          .addNewTodo(_textControler.text);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id != null ? "Edit Todo" : "Add Todo"),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: ListView(
          children: [
            TextField(
              controller: _textControler,
              decoration: InputDecoration(hintText: "Add A Todo"),
            ),
            RaisedButton(
              onPressed: () {
                _addTodo();
              },
              child: Text(
                widget.id != null ? "Edit Todo" : "Add Todo",
              ),
            )
          ],
        ),
      ),
    );
  }
}
