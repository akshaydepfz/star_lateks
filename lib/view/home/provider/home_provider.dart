import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void changeIndexByTap(int index) {
    _selectedIndex = index;
    notifyListeners();
    print(_selectedIndex);
  }
}
