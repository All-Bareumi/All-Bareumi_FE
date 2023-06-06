import 'dart:convert';

import 'package:capstone/LearningReport/reportPage.dart';
import 'package:flutter/material.dart';
import 'package:capstone/LearningReport/reoportContent.dart';
import 'package:http/http.dart' as http;

import 'fetchReportContent.dart';

class ReportListPage extends StatefulWidget {
  const ReportListPage({
    Key? key,
    required this.login_token,
  }) : super(key: key);
  final String login_token;

  @override
  State<ReportListPage> createState() => _ReportListPageState();
}
ReportContent today = new ReportContent(title: '6월 6일', goodSentence: "나는 엄마가 좋아요", badSentence: "나는 운동을 좋아해요", score: 4);
List<ReportContent> reportContents = [today];

class _ReportListPageState extends State<ReportListPage> {
  //List<ReportContent> reportContents = [];

  bool showLearningReportPopup = true;
  ReportContent? reportContent;

  @override
  void initState() {
    super.initState();
    //학습 자료 불러오기
    fetchReportList(widget.login_token).then((materials) {
      setState(() {
        reportContents = materials;
      });
    }).catchError((error) {
      // 에러 처리
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
        itemCount: reportContents.length,
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
                    Navigator.of(context).push(_createRoute(
                        reportContents[index], widget.login_token));
                  },
                  child: Column(
                    children: <Widget>[
                      Text(
                        reportContents[index].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 35,
                            fontFamily: 'Dongle',
                            color: Colors.black),
                      ),
                    ],
                  ),
                )),
          );
        });
  }
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Color(0xffFED40B),
      title: Text(
        '학습 리포트 목록',
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

Route _createRoute(ReportContent reportContent, String login_token) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => new ReportPage(
          reportContent: reportContent, login_token: login_token),
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
}
