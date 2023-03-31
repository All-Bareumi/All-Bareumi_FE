import 'package:flutter/material.dart';

class AddTextPage extends StatelessWidget {
  const AddTextPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFED40B),
      appBar: AppBar(
      elevation: 0.0,
      backgroundColor: Color(0xffFED40B),
      title: Text(
        '텍스트 붙여넣어 학습자료 만들기',
        style: TextStyle(
            color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
      ),
      centerTitle: true,
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          color: const Color(0xff5a4c0c),
          onPressed: () {
            Navigator.pop(context);
          }),
    ),
    );
  }


}
