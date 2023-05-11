import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:capstone/userDrawer/userDataDrawer.dart';

import '../userDrawer/loadingDrawer.dart';

class AddPictureFile extends StatelessWidget {
  const AddPictureFile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("0xffFED40B"),
        endDrawer: LoadingDrawer(),
        appBar: buildAppBar(context),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text('책을 찍어 주세요', textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Dongle', fontSize: 35),),
          ),
        ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: HexColor("0xffFED40B"),
      title: Text(
        '사진찍어 학습자료 만들기',
        style:
        TextStyle(color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
      ),
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          color: HexColor("0xff5a4c0c"),
          onPressed: () {
            Navigator.pop(context);
          }),
      actions: <Widget>[
        Builder(builder: (context) {
          return IconButton(
            icon: Image(
              image: AssetImage('image/logo/logo.png'),
              width: 60,
            ),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          );
        })
      ],
    );
  }
}

class Color {
}
