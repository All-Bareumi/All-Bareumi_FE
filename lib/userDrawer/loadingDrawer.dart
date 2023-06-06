import 'dart:async';
import 'dart:convert';
import 'package:capstone/userDrawer/userData.dart';
import 'package:capstone/userDrawer/userDataDrawer.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:http/http.dart' as http;

class LoadingDrawer extends StatefulWidget {
  const LoadingDrawer({Key? key, required this.login_token, required this.selectedCharacter}) : super(key: key);
  final String login_token;
  final String selectedCharacter;

  @override
  State<LoadingDrawer> createState() => _LoadingDrawerState();
}

class _LoadingDrawerState extends State<LoadingDrawer> {
  Future<UserData> getUserData() async {
    //카카오에서 받아오는 user 정보
    User user = await UserApi.instance.me();
    String? userNameNP = user.kakaoAccount?.profile?.nickname;
    String? profileImgNP = user.kakaoAccount?.profile?.profileImageUrl;
    int userId = user.id;
    String userName = userNameNP ?? "사용자";
    String profileImg = profileImgNP ?? "image/logo/logo.png";
    String nickname = "발음의 마법사";
    int continue_day = 1;
    int targetLearningAmountPerDay = 10;
    String current_reward = "치킨";
    //late int continue_day;
    //late String nickname;
    //late int targetLearningAmountPerDay;
    //late String current_reward;
    // 우리 서버에서 받아오는 user 정보
    var response = await http.get(Uri.parse('http://localhost:8001/api/userData/')); // 여기 bearer 있는 헤더 넣어주어야!!
    if (response.statusCode == 200) {
      // 팝업 내용 가져오기 성공
      var data = jsonDecode(response.body);
      nickname = data['nickname'];
      continue_day = data['continue_day'];
      targetLearningAmountPerDay =data['targetLearningAmountPerDay'];
      current_reward = data['current_reward'];
    } else {
      print('서버에서 drawer를 위한 유저 정보 받아오기 실패');
    }
    return UserData(
      user,
      userName,
      userId,
      profileImg,
      nickname,
      widget.selectedCharacter,
      continue_day,
      targetLearningAmountPerDay,
        current_reward
    );
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return Drawer(
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return Drawer(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 70, 0, 0),
              child: Center(
                child: Column(children: <Widget>[
                  Text(
                    '사용자 정보를',
                    style: TextStyle(fontSize: 40, fontFamily: 'Dongle'),
                  ),
                  Text('불러오지 못했습니다.',
                      style: TextStyle(fontSize: 40, fontFamily: 'Dongle')),
                ]),
              ),
            ));
          } else {
            return myDrawer(
                login_token: widget.login_token,
                userData : snapshot.data!);
          }
        });
  }
}
