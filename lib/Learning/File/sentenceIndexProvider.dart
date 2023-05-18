import 'package:flutter/material.dart';

class SentenceIndexProvider with ChangeNotifier{
  int _sentenceIdx = 0;
  int get sentenceIdx => _sentenceIdx;

  void next(){
    //if (문장 개수 제한)
    _sentenceIdx++;
    notifyListeners();
  }
  void prev(){
    if(_sentenceIdx > 0){
      _sentenceIdx--;
    }
    notifyListeners();
  }
  // 하나의 학습 자료에서 나가면 바로 인덱스 0으로 초기화
  void init(){
    _sentenceIdx = 0;
    notifyListeners();
  }
}