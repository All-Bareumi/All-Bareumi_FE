import 'package:flutter/material.dart';
import 'package:capstone/Learning/learningMaterials.dart';
import 'learningFile.dart';

class FileList extends StatefulWidget {
  const FileList({Key? key}) : super(key: key);

  @override
  State<FileList> createState() => _FileListState();
}

class _FileListState extends State<FileList> {
  static List<String> materialList = [
    "음식",
    "학교",
    "가족",
    "운동",
  ];
  static List<String> materialImgPath = [
    "food",
    "school",
    "family",
    "exercise"
  ];

  final List<LearningMaterial> learningMaterials = List.generate(
      materialList.length,
          (index) =>
          LearningMaterial(materialList[index],
              "image/icon/icon_" + materialImgPath[index] + ".png"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffFED40B),
        endDrawer: _buildDrawer(),
        appBar: buildAppBar(context),
        body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              //mainAxisSpacing: 10,
              //crossAxisSpacing: 10,
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
                                // onTap: () {
                                //   //학습창으로 넘어가기
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //         builder: (BuildContext context) => LearningFile(),
                                //
                                //       ));
                                // },
                                onTap: () {
                                  Navigator.of(context).push(_createRoute());
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
                            learningMaterials[index].name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 35,
                                fontFamily: 'Dongle',
                                color: Colors.black),
                          ),
                          Image(
                              image:
                              AssetImage(learningMaterials[index].imgPath),
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 4),
                        ],
                      ),
                    )),
              );
            }));
  }

  Drawer _buildDrawer() {
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

Route _createRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => LearningFile(),
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
      }
  );
}
