import 'package:flutter/material.dart';

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
      ));
}