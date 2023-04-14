import 'package:flutter/material.dart';

class Character with ChangeNotifier{
  final String name;
  final String imgPath;
  //final String videoPath;

  Character(this.name, this.imgPath);
}