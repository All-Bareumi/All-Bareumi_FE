import 'package:flutter/material.dart';
import 'package:capstone/Learning/File/learningMaterials.dart';

import '../../userDrawer/loadingDrawer.dart';
import 'learningFileServer.dart';

class FileList extends StatefulWidget {
  const FileList({Key? key}) : super(key: key);

  @override
  State<FileList> createState() => _FileListState();
}

class _FileListState extends State<FileList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffFED40B),
        endDrawer: LoadingDrawer(),
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
                                          learningMaterials[index].subject));
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
        ));
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

Route _createRoute(String learningFileName) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
      new LearningFileServer(learningFileName: learningFileName),
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