import 'dart:convert';
import 'dart:ui';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:http/http.dart' as http;
import '../SetCharacter/setCharacter.dart';
import '../SignUp/signUp.dart';

enum LoginPlatform {
  kakao,
  none,
}

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  LoginPlatform _loginPlatform = LoginPlatform.none;

  void signInWithKakao() async {
    try {
      // 카카오톡이 설치되어 있으면 카카오톡 실행 후 로그인, 그렇지 않으면 웹으로 로그인
      bool isInstalled = await isKakaoTalkInstalled();
      OAuthToken token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();

      // https dependency 등록
      final url = Uri.https('kapi.kakao.com', '/v2/user/me');

      final response = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}'
        },
      );
      final profileInfo = json.decode(response.body);
      print(profileInfo.toString());

      setState(() {
        _loginPlatform = LoginPlatform.kakao;
      });

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context)=> SetCharacter(),
          )
      );


    } catch (error) {
      print('카카오톡으로 로그인 실패 ');
    }
  }

  void signOut() async {
    switch (_loginPlatform) {
      case LoginPlatform.kakao:
        break;
      case LoginPlatform.none:
        break;
    }
    setState(() {
      _loginPlatform = LoginPlatform.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffFED40B),
        body: Builder(
          builder: (context) {
            return Column(
              children: <Widget>[
                SizedBox(
                  height: 200,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //SizedBox(width: 80,),
                    Image(
                      image: AssetImage('image/logo/AppName.png'),
                    ),
                    Image(
                      image: AssetImage('image/logo/logo.png'),
                      width: 60,
                    )
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height/2 -30 ,),
                _loginPlatform != LoginPlatform.none
                    ? _logoutButton()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: signInWithKakao,
                              child: Container(
                                child: Image(
                                  image:
                                      AssetImage('image/icon/kakao_login.png'),
                                ),
                              )),
                        ],
                      )
              ],
            );
          },
        ));
  }

  Widget _logoutButton() {
    return ElevatedButton(
      onPressed: signOut,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Colors.grey[400]
        ),
      ),
      child: const Text('로그아웃',style: TextStyle(fontSize: 35, fontFamily: 'Dongle', color: Colors.white),),
    );
  }
}
