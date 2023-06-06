import 'package:capstone/Reward/reward.dart';
import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class RewardListPage extends StatefulWidget {
  const RewardListPage({Key? key, required this.login_token,}) : super(key: key);
  final String login_token;

  @override
  State<RewardListPage> createState() => _RewardListPageState();
}
Reward reward = new Reward(finishedSentenceCnt:50 ,reward_name: "치킨");
List<Reward> rewardList = [reward];

class _RewardListPageState extends State<RewardListPage> {
  //List<ReportContent> reportContents = [];
  //List<Reward> rewardList = [];
  @override
  void initState() {
    super.initState();
    //학습 자료 불러오기
    fetchRewardListData(widget.login_token).then((materials) {
      setState(() {
        rewardList = materials;
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: reportListView(),
    );
  }
  ListView reportListView() {
    return ListView.builder(
        itemCount: rewardList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 2,
                color: Color(0xfffffBDE),
                child: InkWell(
                  onTap: (){
                    //보상 수정이 가능하게끔
                    showModifyRewardPopup(rewardList[index], index);
                    },
                    child: Column(
                        children: <Widget>[
                        Text(
                          rewardList[index].finishedSentenceCnt.toString() +'문장을 공부하면, '+rewardList[index].reward_name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 35,
                              fontFamily: 'Dongle',
                              color: Colors.black),
                        ),
                      ],
                    ),
                ),
            ),
          );
        });
  }

  void showModifyRewardPopup(Reward reward, int index){
    TextEditingController rewardNameController = TextEditingController(text: reward.reward_name);
    TextEditingController finishedSentenceCntController = TextEditingController(text: reward.finishedSentenceCnt.toString());

    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title:Text('보상을 수정합니다.', style: TextStyle(fontFamily: 'Dongle', fontSize: 30),),
        content: Column(
          mainAxisSize : MainAxisSize.min,
          children: [
            TextField(
              controller: rewardNameController,
              decoration:InputDecoration( labelText: '보상 이름'),
            ),
            TextField(
              controller: finishedSentenceCntController,
              decoration: InputDecoration(
                labelText: '공부한 문장 수',
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('취소',style : TextStyle(fontFamily: 'Dongle', fontSize: 30)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('확인',style : TextStyle(fontFamily: 'Dongle', fontSize: 30)),
            onPressed: () {
              if (finishedSentenceCntController.text != null && rewardNameController.text != null){
                updateReward(index, finishedSentenceCntController.text, rewardNameController.text, widget.login_token);
                Navigator.of(context).pop();
              }
              else{
                print('항목에 Null 값이 있습니다');
              }
            },
          ),
        ],
      );
    });
  }
  void updateReward(int index, String finishedSentenceCnt, String rewardName, String login_token) async {
    // 서버로 수정된 데이터 전송
    try {
      final response = await http.put(
        Uri.parse('https://example.com/api/rewards/${rewardList[index]}'),
        headers: {
          'Authorization': 'Bearer ${login_token}',
        },
        body: jsonEncode({
          'finishedSentenceCnt': finishedSentenceCnt,
          'rewardName': rewardName,
        }),
      );

      if (response.statusCode == 200) {
        // 서버 응답 성공
        print('보상 수정 완료');
      } else {
        // 서버 응답 실패
        print('보상 수정 실패');
      }
    } catch (error) {
      // 예외 처리
      print('보상 수정 중 오류 발생: $error');
    }
  }
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Color(0xffFED40B),
      title: Text(
        '학습량 별 보상 목록',
        style:
        TextStyle(color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
      ),
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          color: const Color(0xff5a4c0c),
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }

}
