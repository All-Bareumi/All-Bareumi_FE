import 'dart:ffi';
import 'package:flutter/material.dart';

class Character{
  String name;
  String imgPath;
  //String videoPath;

  Character(this.name, this.imgPath);
}
// extends Character 해주어야 함.
// class SelectedCharacter extends Character with ChangeNotifier{
//   SelectedCharacter(super.name, super.imgPath);
//   void changeCharacter(Character character){
//     this.name = character.name;
//     this.imgPath = character.imgPath;
//     notifyListeners();
//   }
// }
class SelectedCharacter extends ChangeNotifier {
  Character character;
  //String videoPath;

  SelectedCharacter(this.character);
  void setCharacter(Character character){
    this.character = character;
    notifyListeners();
  }
  String getCharacter(){
    return this.character.name;
  }
}