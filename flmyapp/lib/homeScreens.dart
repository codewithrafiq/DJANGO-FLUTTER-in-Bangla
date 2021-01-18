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
    final todoData = Provider.of<GState>(context).todos;
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
      body: Padding(
          padding: EdgeInsets.all(12),
          child: ListView.builder(
            itemCount: todoData.length,
            itemBuilder: (ctx, i) {
              // var item = todoData[i];
              return Card(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Text("${todoData[i].id}"),
                      SizedBox(width: 12),
                      Text(todoData[i].title),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddEditScreens(todoData[i].id),
                            ),
                          );
                        },
                        color: Colors.green,
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          Provider.of<GState>(context, listen: false)
                              .deleteTodo(todoData[i].id);
                        },
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
