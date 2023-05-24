import 'package:flutter/material.dart';

class CharacterProvider with ChangeNotifier{
  String _selectedCharacter = "Elsa";
  String get selectedCharacter => _selectedCharacter;
  void setCharacter(String character){
    _selectedCharacter = character;
    notifyListeners();
  }
}