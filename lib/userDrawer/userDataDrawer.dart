import 'dart:async';
import 'package:capstone/userDrawer/settings.dart';
import 'package:capstone/userDrawer/userData.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import '../LearningReport/fetchReportContent.dart';
import '../LearningReport/reoportContent.dart';
import '../LearningReport/reportListPage.dart';
import '../LearningReport/reportPage.dart';

// void 반환하는 userData 받는 async getUserData 함수 하나 만들기
// getUserData 함수 호출하는 drawer그려주는 stateless widget만들기

class myDrawer extends StatefulWidget {
  const myDrawer({Key? key, required this.userData, required this.login_token})
      : super(key: key);
  final UserData userData;
  final String login_token;

  @override
  State<myDrawer> createState() => _myDrawerState();
}

class _myDrawerState extends State<myDrawer> {

  @override

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 70, 0, 0),
      child: defaultDrawer(context),
    ));
  }


  Column defaultDrawer(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        (widget.userData.profileImg == 'image/logo/logo.png')
            ? Image(image: AssetImage('image/logo/logo.png'), width: 100)
            : CircleAvatar(
                backgroundImage: NetworkImage(widget.userData.profileImg),
                radius: 50),
        SizedBox(height: 20),
        Text(
          '안녕하세요!',
          style: TextStyle(
              color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
        ),
        Row(
          children: [
            Text(
              widget.userData.degree + ', ',
              style: TextStyle(
                  color: Colors.orange, fontFamily: 'Dongle', fontSize: 35),
            ),
            Text(
              widget.userData.userName + '님',
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Text(
              '연속 ',
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
            ),
            Text(
              widget.userData.continue_day.toString(),
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontFamily: 'Dongle',
                  fontSize: 35),
            ),
            Text(
              ' 일째 학습했어요!',
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            //report page로 이동하기
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReportListPage(login_token : widget.login_token)),
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image(
                image: AssetImage('image/logo/logo.png'),
                width: 35,
              ),
              SizedBox(width: 10,),
              Text(
                "학습 리포트 보러가기",
                style: TextStyle(fontFamily: 'Dongle', fontSize: 30),
              ),
            ],
          ),

          style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey,
          elevation: 0),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Text(
              '설정 학습량 : ',
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
            ),
            Text(widget.userData.targetLearningAmountPerDay.toString(),style: TextStyle(
                color: Colors.blueAccent, fontFamily: 'Dongle', fontSize: 35),),
            Text('문장 / 일',style: TextStyle(
                color: Colors.black, fontFamily: 'Dongle', fontSize: 35),),
            TextButton(onPressed: (){}, child: Text('(변경)',style: TextStyle(
                color: Colors.black26, fontFamily: 'Dongle', fontSize: 30)) ),
          ],
        ),

        Row(
          children: [
            Text(
              '조금 더 열심히 하면, ',
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
            ),
            Text(widget.userData.current_reward,style: TextStyle(
                color: Colors.red, fontFamily: 'Dongle', fontSize: 35),),
            Text(
              ' !!!',
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            //report page로 이동하기
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => ReportPage(login_token : widget.login_token)),
            // );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image(
                image: AssetImage('image/logo/logo.png'),
                width: 35,
              ),
              SizedBox(width: 10,),
              Text(
                "보상 확인하기/수정하기",
                style: TextStyle(fontFamily: 'Dongle', fontSize: 30),
              ),
            ],
          ),

          style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey,
              elevation: 0),
        ),
        SizedBox(height: 30),

        Row(
          children: [
            Text(
              '설정 캐릭터 : ',
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
            ),
            Text(
              widget.userData.selectedCharacter,
              style: TextStyle(
                  color: Color(0XFF1086FE), fontFamily: 'Dongle', fontSize: 35),
            ),
          ],
        ),

        SizedBox(height: 10,),

      ],
    );
  }
}
