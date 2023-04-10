import 'package:capstone/AddFile/addPictureFile.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';



class AddPictureFile extends StatelessWidget {
  const AddPictureFile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#FED40B"),
        endDrawer: buildDrawer(),
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

  Drawer buildDrawer() {
    String degree = '발음의 마법사';
    String userName = 'user123';
    return Drawer(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image(
                image: AssetImage('image/logo/logo.png'),
                width: 100,
              ),
              SizedBox(height: 30),
              Text(
                '안녕하세요!',
                style: TextStyle(
                    color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
              ),
              SizedBox(height: 30),
              Text(
                degree,
                style: TextStyle(
                    color: Colors.orange, fontFamily: 'Dongle', fontSize: 35),
              ),
              Text(
                userName + '님',
                style: TextStyle(
                    color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
              ),
              Text(
                '현재 n일째 학습했어요!',
                style: TextStyle(
                    color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
              ),
              SizedBox(height: 30),
              Text(
                '설정 캐릭터',
                style: TextStyle(
                    color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
              ),
              Text(
                ': 내 얼굴',
                style: TextStyle(
                    color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
              ),
            ],
          ),
        )
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
