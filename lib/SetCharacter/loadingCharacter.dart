import 'package:flutter/material.dart';
import 'dart:async';
import 'package:capstone/homePage.dart';

class LoadingCharacter extends StatefulWidget {
  const LoadingCharacter({Key? key}) : super(key: key);

  @override
  State<LoadingCharacter> createState() => _LoadingCharacterState();
}

class _LoadingCharacterState extends State<LoadingCharacter> {
  @override
  void initState() {
    Timer(Duration(milliseconds: 1500), () {
      //if(Condition){
      //  exit(0);
      //}
      Navigator.push(context, MaterialPageRoute(
            builder: (context) => HomePage()));
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFED40B),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xffFED40B),
      ),
      body: Column(
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
                  padding: const EdgeInsets.only(left: 15, top : 13),
                  child: Text('잠시만 기다려줘', style: TextStyle(fontSize: 30, fontFamily: 'Dongle'),),
                ),
              ]),
            ],
          )
        ],
      ),
    );
  }
}
