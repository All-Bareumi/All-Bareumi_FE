import 'dart:convert';
import 'package:capstone/Reward/rewardListPage.dart';
import 'package:capstone/userDrawer/userData.dart';
import 'package:flutter/material.dart';

import '../LearningReport/reportListPage.dart';
import 'package:http/http.dart' as http;

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
            TextButton(onPressed: (){
              showModifyTargetLearningAmountPopup();
            }, child: Text('(변경)',style: TextStyle(
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
            //reward page로 이동하기
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RewardListPage(login_token: widget.login_token),)
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
  void showModifyTargetLearningAmountPopup() {
    TextEditingController targetLearningAmountController =
    TextEditingController(text: widget.userData.targetLearningAmountPerDay.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            '학습량 수정',
            style: TextStyle(fontFamily: 'Dongle', fontSize: 40),
          ),
          content: TextField(
            controller: targetLearningAmountController,
            decoration: InputDecoration(labelText: '학습량'),
            keyboardType: TextInputType.number,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('취소', style: TextStyle(fontFamily: 'Dongle', fontSize: 30)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('확인', style: TextStyle(fontFamily: 'Dongle', fontSize: 30)),
              onPressed: () {
                updateTargetLearningAmount(targetLearningAmountController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void updateTargetLearningAmount(String newAmount) async {
    // 서버로 수정된 데이터 전송
    try {
      final response = await http.put(
        Uri.parse('https://example.com/api/user/target-learning-amount'),
        headers: {
          'Authorization': 'Bearer ${widget.login_token}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'targetLearningAmount': int.parse(newAmount),
        }),
      );

      if (response.statusCode == 200) {
        // 서버 응답 성공
        print('학습량 수정 완료');
        setState(() {
          widget.userData.targetLearningAmountPerDay = int.parse(newAmount);
        });
      } else {
        // 서버 응답 실패
        print('학습량 수정 실패');
      }
    } catch (error) {
      // 예외 처리
      print('학습량 수정 중 오류 발생: $error');
    }
  }

}
