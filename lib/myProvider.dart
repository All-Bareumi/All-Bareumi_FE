import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Index_Provider with ChangeNotifier {
  int _idx = 0;

  int get idx => _idx;

  void next() {
    if(_idx<5){
      _idx++;
      notifyListeners();
    }

  }

  void prev() {
    if(_idx>=0){
      _idx--;
      notifyListeners();
    }
  }
}


// class Character_Provider with ChangeNotifier{
//   String _characterName;
//   String get characterName
// }