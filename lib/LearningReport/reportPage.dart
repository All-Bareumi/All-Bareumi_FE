import 'package:capstone/LearningReport/reoportContent.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  const ReportPage(
      {Key? key, required this.reportContent, required this.login_token})
      : super(key: key);
  final ReportContent reportContent;
  final String login_token;

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildAppBar(context), body: buildReportPage());
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Color(0xffFED40B),
      title: Text(
        widget.reportContent.title + '의 학습 리포트',
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

  Column buildReportPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 15,),
        Stack(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('image/design/bubble5.png'),
                height: 130,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '발음의 마법사까지',
                  style: TextStyle(fontFamily: 'Dongle', fontSize: 35),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      (100 - widget.reportContent.score * 20).toString() + '%',
                      style: TextStyle(
                          fontFamily: 'Dongle',
                          fontSize: 43,
                          color: Colors.blueAccent),
                    ),
                    Text(
                      ' 남았어요',
                      style: TextStyle(fontFamily: 'Dongle', fontSize: 35),
                    ),
                  ],
                ),
              ],
            ),
          )
        ]),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Image(
            image: AssetImage('image/logo/logo.png'),
            width: MediaQuery.of(context).size.width - 120,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.yellow),
              Text(
                '가장 잘 말한 문장',
                style: TextStyle(fontFamily: 'Dongle', fontSize: 35),
              ),
              Icon(Icons.star, color: Colors.yellow)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
            alignment: Alignment.center,
            child: Row(
              children: [
                Icon(Icons.arrow_right_outlined),
                Text(
                  widget.reportContent!.goodSentence,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Dongle', fontSize: 35, color: Colors.black),
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xfffffBDE)),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.yellow),
              Text(
                '가장 어려웠던 문장',
                style: TextStyle(fontFamily: 'Dongle', fontSize: 35),
              ),
              Icon(Icons.star, color: Colors.yellow)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
            alignment: Alignment.center,
            child: Row(
              children: [
                Icon(Icons.arrow_right_outlined),
                Text(
                  widget.reportContent!.badSentence,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Dongle', fontSize: 35, color: Colors.black),
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xfffffBDE)),
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Image(image: AssetImage('image/design/rainbow.png'), width: 50,),
                Text(
                ' 정말 잘했어요! ',
                style: TextStyle(fontFamily: 'Dongle', fontSize: 50),
              ),
                Image(image: AssetImage('image/design/rainbow.png'), width: 50,),
              ],
            )

          ],
        ),
      ],
    );
  }
}
