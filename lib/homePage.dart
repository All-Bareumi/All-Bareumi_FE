import 'package:flutter/material.dart';
import 'package:capstone/Learning/fileList.dart.dart';
import 'package:capstone/Learning/learningVideo.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffFED40B),
        endDrawer: buildDrawer(),
        appBar: buildAppBar(context),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => LearningFile(),
                        ));
                  },
                  child: Stack(children: <Widget>[
                    Container(
                      child: Text(
                        '기존 자료로 학습하기',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Dongle',
                            fontSize: 40,
                            color: Colors.white),
                      ),
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xffED5555)),
                    ),
                    //buildColumn(),
                  ]),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => LearningVideo(),
                        ));
                  },
                  child: Stack(children: <Widget>[
                    Container(
                      child: Text(
                        '영상으로 학습하기',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Dongle',
                            fontSize: 40,
                            color: Colors.white),
                      ),
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xff1AB846)),
                    ),

                    Row(
                      children: [
                        Image(image: AssetImage('image/icon/노란상어.png'),),
                        Image(image: AssetImage('image/icon/핑크퐁_새우.png'),),
                      ],
                    ),
                  ]),
                ),
              ],
            ),
            Stack(children: <Widget>[
              Container(
                child: Text(
                  '새로운 자료 추가하기',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Dongle', fontSize: 40, color: Colors.white),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0XFF1086FE)),
              ),
            ])
          ],
        ));
  }

  Column buildColumn() {
    return Column(
                    children: [
                      SizedBox(height: 60,),
                      Row(
                        children: <Widget>[
                          Image(
                            image: AssetImage('image/icon/hangeul/이응.png'),
                            width: 10,
                          ),
                          Image(
                            image: AssetImage('image/icon/hangeul/비읍.png'),
                            width: 10,
                          ),
                          Image(
                            image: AssetImage('image/icon/hangeul/리을.png'),
                            width: 10,
                          ),
                          Image(
                            image: AssetImage('image/icon/hangeul/미음.png'),
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Image(
                            image: AssetImage('image/icon/hangeul/오.png'),
                            width: 10,
                          ),
                          Image(
                            image: AssetImage('image/icon/hangeul/아.png'),
                            width: 10,
                          ),
                          Image(
                            image: AssetImage('image/icon/hangeul/으.png'),
                            width: 10,
                          ),
                          Image(
                            image: AssetImage('image/icon/hangeul/이.png'),
                            width: 10,
                          ),
                        ],
                      ),
                    ],
                  );
  }

  Drawer buildDrawer() {
    String degree = '발음의 마법사';
    String userName = 'user123';
    return Drawer(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image(
            image: AssetImage('image/logo/logo.png'),
            width: 100,
          ),
          SizedBox(height: 30),
          Text(
            '안녕하세요!',
            style: TextStyle(
                color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
          ),
          SizedBox(height: 30),
          Text(
            degree,
            style: TextStyle(
                color: Colors.orange, fontFamily: 'Dongle', fontSize: 35),
          ),
          Text(
            userName + '님',
            style: TextStyle(
                color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
          ),
          Text(
            '현재 n일째 학습했어요!',
            style: TextStyle(
                color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
          ),
          SizedBox(height: 30),
          Text(
            '설정 캐릭터',
            style: TextStyle(
                color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
          ),
          Text(
            ': 내 얼굴',
            style: TextStyle(
                color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
          ),
        ],
      ),
    ));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Color(0xffFED40B),
      title: Text(
        '홈',
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
