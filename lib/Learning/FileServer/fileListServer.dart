import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:capstone/Learning/FileServer/learningMaterialsServer.dart';

import '../../userDrawer/loadingDrawer.dart';
import 'package:capstone/LearningReport/reoportContent.dart';
import 'fetchLearningMaterial.dart';
import 'learningFileServer.dart';
import 'package:http/http.dart' as http;


class FileListServer extends StatefulWidget {
  const FileListServer({Key? key, required this.login_token, required this.selectedCharacter}) : super(key: key);

  final String login_token;
  final String selectedCharacter;
  @override
  State<FileListServer> createState() => _FileListServerState();
}

class _FileListServerState extends State<FileListServer> {
  List<LearningMaterialServer> learningMaterials = [];

  bool showLearningReportPopup = true;
  ReportContent? reportContent;

  Future<bool> fetchServerResponse() async {
    final url =
    Uri.parse('http://localhost:8001/api/'); // 오늘의 학습량 목표를 도달했는지 확인하기 위한 서버

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final boolValue = data['goalAchived']; // Replace 'response' with the actual key in your server response
        return boolValue;
      } else {
        // Handle error case if the request was not successful
        throw Exception('Failed to fetch server response');
      }
    } catch (e) {
      // Handle network or other runtime errors
      throw Exception('Failed to connect to the server');
    }
  }

  @override
  void initState(){
    super.initState();
    //학습 자료 불러오기
    fetchLearningMaterials(widget.login_token, widget.selectedCharacter).then((materials) {
      setState(() {
        learningMaterials = materials;
      });
    }).catchError((error) {
      // 에러 처리
      print(error);
    });

    // 오늘의 학습 리포트 불러오기
    fetchServerResponse().then((bool serverResponse) {
      setState(() {
        showLearningReportPopup = serverResponse;
      });
    }).catchError((error) {
      print('Failed to fetch server response: $error');
      // Handle the error case accordingly
    });
    // if (showLearningReportPopup) {
    //   fetchData();
    // }
  }
  void showAlert(BuildContext context){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text('오늘 학습 완료!',style: TextStyle(fontFamily: 'Dongle', fontSize: 40, color: Color(0xff1AB846)),
          textAlign: TextAlign.center),
        content: Text('학습 리포트가 생성되었어요.\n확인하러 가볼까요?', style: TextStyle(fontFamily: 'Dongle', fontSize: 30),
            textAlign: TextAlign.center),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    if (showLearningReportPopup) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        showAlert(context);
      });
    }
    return Scaffold(
        backgroundColor: Color(0xffFED40B),
        endDrawer: LoadingDrawer(login_token: widget.login_token, selectedCharacter: widget.selectedCharacter),
        appBar: buildAppBar(context),
        body: Stack(
          children: <Widget>[
            Column(
                children:<Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height/16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image(image: AssetImage("image/design/WhiteEllipseTop.png")),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/4),
                  Row(
                    children: [
                      //SizedBox(width: 30,),
                      Image(image: AssetImage("image/design/WhiteEllipseBottom.png")),
                    ],
                  )
                ]
            ),
            GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: learningMaterials.length,
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
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                builder: (BuildContext context) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(_createRoute(
                                          learningMaterials[index], widget.login_token));
                                    },
                                    child: Container(
                                      height: 200,
                                      //color: Colors.transparent,
                                      child: Text(
                                        '학습 시작하기',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 60,
                                            fontFamily: 'Dongle'),
                                      ),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30),
                                        ),
                                        color: Color(0XFFED5555),
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Column(
                            children: <Widget>[
                              Text(
                                learningMaterials[index].subjectKor,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 35,
                                    fontFamily: 'Dongle',
                                    color: Colors.black),
                              ),
                              Image(
                                  image:
                                  AssetImage(learningMaterials[index].imgPath),
                                  width: MediaQuery.of(context).size.width / 4),
                            ],
                          ),
                        )),
                  );
                }),],
        )
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Color(0xffFED40B),
      title: Text(
        '학습 자료 목록',
        style:
        TextStyle(color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
      ),
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          color: const Color(0xff5a4c0c),
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

Route _createRoute(LearningMaterialServer learningMaterialServer, String login_token) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
      new LearningFileServer(learningMaterialServer: learningMaterialServer, login_token: login_token,),
      // pageBuilder: (context, animation, secondaryAnimation) =>
      // new LearningFile(learningMaterial: learningMaterial),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var curveTween = CurveTween(curve: curve);

        var tween = Tween(begin: begin, end: end).chain(curveTween);
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      });
}
