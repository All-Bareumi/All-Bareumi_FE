import 'package:capstone/AddFile/addNewFileCategoryPage.dart';
import 'package:flutter/material.dart';
import 'package:capstone/Learning/File/fileList.dart';
import 'package:capstone/Learning/Video/videoFileList.dart';
import 'package:capstone/AddFile/addNewFilePage.dart';
import 'AddFileServer/addNewFileCategoryPageServer.dart';
import 'Learning/FileServer/fileListServer.dart';
import 'userDrawer/loadingDrawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.login_token, required this.selectedCharacter}) : super(key: key);
  final String login_token;
  final String selectedCharacter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffFED40B),
        endDrawer: LoadingDrawer(login_token: login_token, selectedCharacter : selectedCharacter),
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
            Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => FileList(login_token: login_token, selectedCharacter: selectedCharacter,),
                            //builder: (BuildContext context) => FileListServer(login_token: login_token, selectedCharacter: selectedCharacter,),
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
                      buildColumn(),
                    ]),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => VideoFileList(login_token: login_token, selectedCharacter: selectedCharacter),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 70),
                        child: Row(
                          children: [
                            Image(
                              image: AssetImage('image/icon/yellowShark.png'),
                              width: 120,
                            ),
                            Image(
                              image: AssetImage('image/icon/pinkfong_shrimp.png'),
                              width: 60,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 115, left: 75),
                          child: Image(
                              image: AssetImage('image/icon/icon_youtube.png')))
                    ]),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => AddNewFileCategoryPageServer(login_token: login_token, selectedCharacter: selectedCharacter),
                      ));
                },
                child: Stack(children: <Widget>[
                  Container(
                    child: Text(
                      '새로운 자료 추가하기',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Dongle',
                          fontSize: 40,
                          color: Colors.white),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0XFF1086FE)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 60, left: 45),
                    child: Row(children: <Widget>[
                      Image(image: AssetImage('image/icon/book1.jpeg'), width: 100),
                      Icon(Icons.add, size: 100,color: Colors.white,),
                      Image(image: AssetImage('image/icon/book2.jpeg'), width: 100),
                    ]),
                  )
                ]),
              )
            ],
          ),],
        ));
  }

  Column buildColumn() {
    return Column(
      children: [
        SizedBox(
          height: 80,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 7,
            ),
            Image(
              image: AssetImage('image/icon/hangeul/eung.png'),
              width: 45,
            ),
            Image(
              image: AssetImage('image/icon/hangeul/bieup.png'),
              width: 45,
            ),
            Image(
              image: AssetImage('image/icon/hangeul/rieul.png'),
              width: 45,
            ),
            Image(
              image: AssetImage('image/icon/hangeul/mieum.png'),
              width: 45,
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 7,
            ),
            Image(
              image: AssetImage('image/icon/hangeul/o.png'),
              width: 45,
            ),
            Image(
              image: AssetImage('image/icon/hangeul/a.png'),
              width: 45,
            ),
            Image(
              image: AssetImage('image/icon/hangeul/eui.png'),
              width: 45,
            ),
            Image(
              image: AssetImage('image/icon/hangeul/i.png'),
              width: 45,
            ),
          ],
        ),
      ],
    );
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
