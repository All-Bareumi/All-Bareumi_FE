import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Index_Provider with ChangeNotifier {
  int _idx = 0;

  int get idx => _idx;

  void next() {
    _idx++;
    notifyListeners();
  }

  void prev() {
    _idx--;
    notifyListeners();
  }
}


// class Character_Provider with ChangeNotifier{
//   String _characterName;
//   String get characterName
// }