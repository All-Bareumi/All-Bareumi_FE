import'package:flutter/material.dart';

Route createRoute(StatefulWidget page1, StatefulWidget page2){
  return PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation)=> page2(),
  )
}