import 'dart:convert';
import 'dart:io';
import 'package:capstone/imageUploader.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../CameraPage.dart';
import '../userDrawer/loadingDrawer.dart';
import 'addTextPage.dart';
import 'package:http/http.dart' as http;

class AddNewFilePage extends StatefulWidget {
  const AddNewFilePage({Key? key, required this.login_token}) : super(key: key);
  final String login_token;

  @override
  State<AddNewFilePage> createState() => _AddNewFilePageState();
}

class _AddNewFilePageState extends State<AddNewFilePage> {
  final String hexYellow = "FED40B";
  final String hexGreen = "1AB846";
  final String hexBlue = "1086fe";
  final String hexRed = "ED5555";

  TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _textFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(hexYellow),
      endDrawer: LoadingDrawer(login_token: widget.login_token),
      appBar: buildAppBar(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text(
                          '추가할 학습 자료의 제목을\n입력하세요.',
                          style: TextStyle(
                              fontSize: 35,
                              fontFamily: 'Dongle',
                              color: Colors.black),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        content: TextField(
                          onChanged: (value) {},
                          controller: _textFieldController,
                          decoration: InputDecoration(hintText: "제목"),
                        ),
                        actions: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ImageUploader(
                                                textSubject:
                                                    _textFieldController.text,
                                                login_token: widget.login_token,
                                                pageName: '사진 업로드 하기',
                                              )));
                                  _textFieldController.text = '';
                                },
                                child: Container(
                                    child: const Text(
                                  '확인',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontFamily: 'Dongle',
                                      color: Colors.black),
                                )),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'cancel');
                                  _textFieldController.text = '';
                                },
                                child: const Text(
                                  '취소',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontFamily: 'Dongle',
                                      color: Colors.black),
                                ),
                              )
                            ],
                          ),
                        ],
                      ));
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: Text(
                  '사진찍어\n학습자료 만들기',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Dongle',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: HexColor(hexGreen)),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text(
                          '추가할 학습 자료의 제목을\n입력하세요.',
                          style: TextStyle(
                              fontSize: 35,
                              fontFamily: 'Dongle',
                              color: Colors.black),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        content: TextField(
                          onChanged: (value) {},
                          controller: _textFieldController,
                          decoration: InputDecoration(hintText: "제목"),
                        ),
                        actions: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextButton(
                                onPressed: () async{
                                  String textSubject = _textFieldController.text;
                                  try {
                                    var response = await http.post(
                                      Uri.parse(
                                        'http://localhost:8001/api/learning/sentences/category', // 추가되는 문장 경로 추가하기
                                      ),
                                      body: jsonEncode({
                                        'category': textSubject,
                                      }),
                                      headers: {
                                        "Content-Type": "application/json",
                                        HttpHeaders.authorizationHeader:
                                        'Bearer ${widget.login_token}'
                                      },
                                    );
                                    print(response.body);

                                  } catch (e) {
                                    print(e);

                                  }
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddTextPage(
                                                textSubject:
                                                textSubject,
                                                login_token: widget.login_token,
                                              )));
                                  _textFieldController.text = '';
                                },
                                child: Container(
                                    child: const Text(
                                  '확인',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontFamily: 'Dongle',
                                      color: Colors.black),
                                )),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'cancel');
                                  _textFieldController.text = '';
                                },
                                child: const Text(
                                  '취소',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontFamily: 'Dongle',
                                      color: Colors.black),
                                ),
                              )
                            ],
                          ),
                        ],
                      ));
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: Text(
                  '텍스트 붙여넣어\n학습자료 만들기',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Dongle',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: HexColor(hexBlue)),
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: HexColor(hexYellow),
      title: Text(
        '새로운 학습자료 추가하기',
        style:
            TextStyle(color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
      ),
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          color: HexColor("5a4c0c"),
          onPressed: () {
            Navigator.pop(context);
          }),
      actions: <Widget>[
        Builder(builder: (context) {
          return IconButton(
            icon: Image(
              image: AssetImage('image/logo/logo.png'),
              width: 60,
            ),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          );
        })
      ],
    );
  }
}
