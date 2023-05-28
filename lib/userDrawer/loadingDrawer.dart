import 'dart:async';
import 'package:capstone/userDrawer/userDataDrawer.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class LoadingDrawer extends StatefulWidget {
  const LoadingDrawer({Key? key, required this.login_token}) : super(key: key);
  final String login_token;

  @override
  State<LoadingDrawer> createState() => _LoadingDrawerState();
}

class UserInfo {
  final User user;
  final String userName;
  final int userId;
  final String profileImg;

  UserInfo(this.user, this.userName, this.userId, this.profileImg);
}

class _LoadingDrawerState extends State<LoadingDrawer> {
  Future<UserInfo> getUserData() async {
    //카카오에서 받아오는 user 정보
    User user = await UserApi.instance.me();
    String? userNameNP = user.kakaoAccount?.profile?.nickname;
    String? profileImgNP = user.kakaoAccount?.profile?.profileImageUrl;
    int userId = user.id;
    String userName = userNameNP ?? "사용자";
    String profileImg = profileImgNP ?? "image/logo/logo.png";
    return UserInfo(
      user,
      userName,
      userId,
      profileImg,
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
                user: snapshot.data!.user,
                userName: snapshot.data!.userName.toString(),
                userId: snapshot.data!.userId,
                profileImg: snapshot.data!.profileImg.toString());
          }
        });
  }
}
