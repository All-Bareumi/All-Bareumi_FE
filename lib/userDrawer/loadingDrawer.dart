import 'dart:async';
import 'package:capstone/userDrawer/userDataDrawer.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class LoadingDrawer extends StatefulWidget {
  const LoadingDrawer({Key? key}) : super(key: key);

  @override
  State<LoadingDrawer> createState() => _LoadingDrawerState();
}

class _LoadingDrawerState extends State<LoadingDrawer> {
  bool notNullUser = false;
  late User user;
  late String? userNameNP; // null 가능 상태
  late String? profileImgNP;
  late int userId;
  late String userName;
  late String profileImg;

  Future<User> getUserData() async {
    //카카오에서 받아오는 user 정보
    user = await UserApi.instance.me();
    return user;
  }

  @override
  void initState() {
    super.initState();
    //getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          userNameNP = user.kakaoAccount?.profile?.nickname;
          profileImgNP = user.kakaoAccount?.profile?.profileImageUrl;
          userId = user.id;
          userName = userNameNP ?? "사용자";
          profileImg = profileImgNP ?? "image/logo/logo.png";
          if (snapshot.hasData == false) {
            return Drawer(
              child: CircularProgressIndicator(),
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
                user: user,
                userName: userName,
                userId: userId,
                profileImg: profileImg);
          }
        });
  }
}
