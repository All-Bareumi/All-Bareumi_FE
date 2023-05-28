import 'dart:async';
import 'package:capstone/userDrawer/settings.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

// void 반환하는 userData 받는 async getUserData 함수 하나 만들기
// getUserData 함수 호출하는 drawer그려주는 stateless widget만들기

class myDrawer extends StatefulWidget {
  const myDrawer({Key? key,
    required this.user,
    required this.userName,
    required this.userId,
    required this.profileImg,
    required this.login_token})
      : super(key: key);
  final User user;
  final String userName;
  final int userId;
  final String profileImg;
  final String login_token;

  @override
  State<myDrawer> createState() => _myDrawerState();
}

class _myDrawerState extends State<myDrawer> {
  @override
  String degree = "발음의 마법사";

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 70, 0, 0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
          (widget.profileImg == 'image/logo/logo.png')
              ? Image(image: AssetImage('image/logo/logo.png'), width: 100)
              : CircleAvatar(
              backgroundImage: NetworkImage(widget.profileImg), radius: 50),
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
            widget.userName + '님',
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
          SizedBox(height: 200),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(icon: Icon(Icons.settings, size: 40,),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Settings(login_token: widget.login_token)));
                },),
                SizedBox(width: 20),
                ],
              ),
            ],
          ),
        )
    );
  }
}
