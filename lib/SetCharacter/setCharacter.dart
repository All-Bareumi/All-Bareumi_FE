import 'package:capstone/CameraPage.dart';
import 'package:capstone/SetCharacter/selectMyAvatar.dart';
import 'package:capstone/SetCharacter/setMyAvatar.dart';
import 'package:flutter/material.dart';
import '../userDrawer/loadingDrawer.dart';
import 'character.dart';
import 'selectCharacter.dart';
import 'myAvatar.dart';
import 'package:capstone/userDrawer/userDataDrawer.dart';

//List<Character> Characters= [];

class SetCharacter extends StatelessWidget {
  const SetCharacter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFED40B),
      endDrawer: LoadingDrawer(),
      appBar: buildAppBar(context),
      body: Stack(
        children: <Widget>[
          Column(children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height / 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image(image: AssetImage("image/design/WhiteEllipseTop.png")),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 4),
            Row(
              children: [
                //SizedBox(width: 30,),
                Image(image: AssetImage("image/design/WhiteEllipseBottom.png")),
              ],
            )
          ]),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SelectCharacter(),
                              ));
                        },
                        child: _buildChooseCharacter(
                            '캐릭터 입모양', '생성하기', 'elsa_face', 'Blue', context),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                //builder: (BuildContext context) => CameraPage(text: "내 얼굴을 찍어주세요"),
                                builder: (BuildContext context) => SetMyAvatar(),
                              ));
                        },
                        child: _buildChooseCharacter(
                            '내 얼굴로 입모양', '생성하기', 'camera', 'Green', context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Color(0xffFED40B),
      title: Text(
        '캐릭터 설정',
        style:
            TextStyle(color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
      ),
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          color: const Color(0xff5a4c0c),
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

  Container _buildChooseCharacter(String str1, String str2, String icon,
      String color, BuildContext context) {
    int hex_color;
    if (color == 'Green') {
      hex_color = 0xff1AB846;
    } else {
      hex_color = 0xFF1086FE;
    }
    return Container(
      child: Stack(
        children: <Widget>[
          Image.asset('image/design/' + color + 'Vector_chooseChar.png'),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(38, 40, 0, 0),
                child: Center(
                    child: Column(
                  children: [
                    Text(
                      str1,
                      style: TextStyle(
                          fontFamily: 'Dongle',
                          fontSize: 30,
                          color: Colors.white),
                    ),
                    Text(
                      str2,
                      style: TextStyle(
                          fontFamily: 'Dongle',
                          fontSize: 30,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CircleAvatar(
                      backgroundImage:
                          AssetImage('image/icon/icon_' + icon + '.png'),
                      backgroundColor: Color(hex_color),
                      radius: 50,
                    ),
                  ],
                )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}