import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../CameraPage.dart';
import '../userDrawer/loadingDrawer.dart';
import 'addTextPage.dart';
import 'package:capstone/userDrawer/userDataDrawer.dart';

class AddNewFilePage extends StatelessWidget {
  const AddNewFilePage({Key? key}) : super(key: key);

  final String hexYellow ="FED40B";
  final String hexGreen ="1AB846";
  final String hexBlue ="1086fe";
  final String hexRed ="ED5555";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(hexYellow),
      endDrawer: LoadingDrawer(),
      appBar: buildAppBar(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => CameraPage(text: "책을 찍어주세요",),
                  )
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: Text(
                  '사진찍어\n학습자료 만들기',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Dongle',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: HexColor(hexGreen)),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    //builder: (BuildContext context) => AddPictureFile(),
                    builder: (BuildContext context) => AddTextPage(),
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: Text(
                  '텍스트 붙여넣어\n학습자료 만들기',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Dongle',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: HexColor(hexBlue)),
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: HexColor(hexYellow),
      title: Text(
        '새로운 학습자료 추가하기',
        style:
            TextStyle(color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
      ),
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          color:  HexColor("5a4c0c"),
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
