import 'package:flutter/material.dart';

class SentenceIndex with ChangeNotifier{
  int _sentenceIdx = 0;
  int get sentenceIdx => _sentenceIdx;

  void next(){
    _sentenceIdx++;
    notifyListeners();
  }
  void prev(){
    _sentenceIdx--;
    notifyListeners();
  }
}