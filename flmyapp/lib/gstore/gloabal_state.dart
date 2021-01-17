import 'package:flutter/cupertino.dart';

class GState with ChangeNotifier {
  List<String> _datas = [
    "Data 1",
    "Data 2",
    "Data 3",
    "Data 4",
    "Data 5",
  ];

  List<String> get data {
    return [..._datas];
  }

  void addData(String data) {
    _datas.insert(0, data);
    notifyListeners();
  }
}
