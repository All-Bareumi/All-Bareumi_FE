import 'package:capstone/Learning/File/fileList.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:capstone/homePage.dart';

import '../Learning/FileServer/fileListServer.dart';

class LoadingCharacter extends StatefulWidget {
  const LoadingCharacter({Key? key, required this.login_token, required this.selectedCharacter}) : super(key: key);
  final String login_token;
  final String selectedCharacter;
  @override
  State<LoadingCharacter> createState() => _LoadingCharacterState();
}

class _LoadingCharacterState extends State<LoadingCharacter> {
  @override
  void initState() {
    Timer(Duration(milliseconds: 1500), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage(login_token: widget.login_token, selectedCharacter: widget.selectedCharacter,)));
      showDialog(
          context: context,
          builder: (c) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                content: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    Text('오늘의 학습 목표!',
                        style: TextStyle(fontFamily: 'Dongle', fontSize: 50)),
                    Text('새로운 문장',
                        style: TextStyle(fontFamily: 'Dongle', fontSize: 40)),
                    Text('10개 학습', // server에서 받아온 값 (부모님이 설정해둔 값)
                        style: TextStyle(fontFamily: 'Dongle', fontSize: 40)),
                  ]),
                ),
                actions: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FileListServer(login_token: widget.login_token, selectedCharacter: widget.selectedCharacter)));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xffED5555)),
                                child: const Text(
                                  '  학습하기  ',
                                  style: TextStyle(
                                      fontSize: 45,
                                      fontFamily: 'Dongle',
                                      color: Colors.white),
                                ))),
                        TextButton(
                            onPressed: () => Navigator.pop(context, 'cancel'),
                            child: const Text(
                              '닫기',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'Dongle',
                                  color: Colors.black),
                            ))
                      ]),
                ],
              ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFED40B),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xffFED40B),
      ),
      body: Stack(children: <Widget>[
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
        Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Center(
              child: Image(
                image: AssetImage('image/logo/AppName.png'),
                width: 130,
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Text(
              '선택한 캐릭터로',
              style: TextStyle(fontFamily: 'Dongle', fontSize: 40),
            ),
            Text(
              '설정중입니다.',
              style: TextStyle(fontFamily: 'Dongle', fontSize: 40),
            ),
            SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 60, top: 50),
                  child: Image(
                    image: AssetImage('image/logo/logo.png'),
                    width: 70,
                  ),
                ),
                Stack(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: Image(
                      image: AssetImage('image/icon/icon_message.png'),
                      width: 150,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 13),
                    child: Text(
                      '잠시만 기다려줘',
                      style: TextStyle(fontSize: 30, fontFamily: 'Dongle'),
                    ),
                  ),
                ]),
              ],
            )
          ],
        ),
      ]),
    );
  }
}
