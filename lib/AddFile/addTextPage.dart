import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTextPage extends StatelessWidget {
  const AddTextPage(
      {Key? key, required this.textSubject, required this.login_token})
      : super(key: key);
  final String textSubject;
  final String login_token;

  @override
  Widget build(BuildContext context) {
    print('AddTextPage: ' + textSubject);

    return Scaffold(
      backgroundColor: const Color(0xffFED40B),
      appBar: buildAppBar(context),
      body: TextScreen(textSubject: textSubject, login_token: login_token),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Color(0xffFED40B),
      title: Text(
        '텍스트 붙여넣어 학습자료 만들기',
        style:
            TextStyle(color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
      ),
      centerTitle: true,
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          color: const Color(0xff5a4c0c),
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }
}

class TextScreen extends StatefulWidget {
  const TextScreen(
      {Key? key, required this.textSubject, required this.login_token})
      : super(key: key);
  final String login_token;
  final String textSubject;

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              left: 30, right: 30, top: MediaQuery.of(context).size.height / 6),
          child: TextField(
              controller: myController,
              maxLines: 5,
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Dongle', fontSize: 30),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xfffef9ed),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(30)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent, width: 2),
                      borderRadius: BorderRadius.circular(30)))),
        ),
        InkWell(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Container(
                child: Text(
                  "완료",
                  style: TextStyle(
                      fontFamily: 'Dongle', fontSize: 45, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                width: MediaQuery.of(context).size.width / 4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color(0xffED5555)),
              ),
            ),
            onTap: () async {
              showDialog(
                  //실제로는 DB에 저장되고 이런 알림메시지는 보여주지 않을 예정
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(
                        '추가하고 싶은 문장이\n"' + myController.text + '"\n이 맞나요?',
                        style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'Dongle',
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                            onPressed: () async {
                              Navigator.of(context).pop();

                              print(
                                  "textPage : action : " + widget.textSubject);
                              try {
                                var response = await http.put(
                                  Uri.parse(
                                    'http://localhost:8001/api/learning/sentences/insert', // 추가되는 문장 경로 추가하기
                                  ),
                                  body: jsonEncode({
                                    //'category': "food",
                                    // 추가할 학습 자료의 제목
                                    'category': widget.textSubject,
                                    // 추가할 학습 자료의 제목
                                    'content': myController.text,
                                    //'content': "food",
                                  }),
                                  headers: {
                                    "Content-Type": "application/json",
                                    HttpHeaders.authorizationHeader:
                                        'Bearer ${widget.login_token}'
                                  },
                                );
                                print('성공적으로 업로드했습니다');
                                print(response.body);

                              } catch (e) {
                                print(e);
                              }
                            },
                            child: Text('네')),
                        ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('아니요')),
                      ],
                    );
                  });
            })
      ],
    );
  }
}
