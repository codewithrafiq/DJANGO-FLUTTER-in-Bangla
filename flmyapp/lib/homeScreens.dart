import 'package:flmyapp/add_data.dart';
import 'package:flmyapp/gstore/gloabal_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final getetData = Provider.of<GState>(context).data;
    return Scaffold(
      appBar: AppBar(
        title: Text("G Store"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddData.routeName);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: getetData.length,
          itemBuilder: (ctx, i) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text("${getetData[i]}"),
              ),
            );
          },
        ),
      ),
    );
  }
}
