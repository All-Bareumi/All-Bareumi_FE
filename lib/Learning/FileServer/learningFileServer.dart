import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:capstone/Learning/FileServer/learningMaterialsServer.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'videoAndTextScreenServer.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:http/http.dart' as http;


class LearningFileServer extends StatefulWidget {
  const LearningFileServer({Key? key, required this.learningMaterialServer, required this.login_token})
      : super(key: key);

  final LearningMaterialServer learningMaterialServer;
  final String login_token;

  @override
  State<LearningFileServer> createState() => _LearningFileServerState();
}

class _LearningFileServerState extends State<LearningFileServer> {
  // 카메라 기능
  late CameraController _cameraController;
  Future<void>? _initializeCameraControllerFuture;

  int sentIndex = 0;

  @override
  void initState() {
    super.initState();
    //카메라
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    int frontIdx = 0;
    // 전면 카메라를 바로 켜야하기 때문에!
    print("카메라는 총 ${cameras.length}개 있어요");
    for (int idx = 0; idx < cameras.length; idx++) {
      if (cameras[idx] == CameraLensDirection.front) {
        frontIdx = idx;
        break;
      }
    }
    print("그 중 전면 카메라는 ${frontIdx} 예요");

    _cameraController =
        CameraController(cameras[frontIdx], ResolutionPreset.veryHigh);
    _initializeCameraControllerFuture =
        _cameraController!.initialize().then((value) {
          setState(() {});
        });
  }

  @override
  void dispose() {
    // 위젯의 생명주기 종료시 컨트롤러 역시 해제시켜줍니다.
    _cameraController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        endDrawer: Drawer(),
        appBar: buildAppBar(context),
        body: buildBody(context));
  }

  Column buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        VideoAndTextScreen(
          learningMaterial: widget.learningMaterialServer,
          sentIndex: sentIndex,
          login_token: widget.login_token,
        ),
        buildCameraFutureBuilder(),
        learningProgress(),
        buildPrevAndNextRow(context),
      ],
    );
  }

  Padding buildPrevAndNextRow(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: sentIndex != 0
            ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      if (sentIndex > 0) {
                        sentIndex--;
                      }
                    });
                  },
                  child: Text(
                    "< 이전",
                    style:
                    TextStyle(fontFamily: 'Dongle', fontSize: 30),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      if (sentIndex >=
                          (widget.learningMaterialServer.sentences
                              ?.length ??
                              1) -
                              1) {
                        Navigator.pop(context);
                        sentIndex = 0;
                      } else {
                        sentIndex++;
                      }
                    });
                  },
                  child: Text(
                    "다음 >",
                    style:
                    TextStyle(fontFamily: 'Dongle', fontSize: 30),
                  )),
            ),
          ],
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      if (sentIndex >=
                          (widget.learningMaterialServer.sentences
                              ?.length ??
                              0) -
                              1) {
                        Navigator.pop(context);
                      } else {
                        sentIndex++;
                      }
                    });
                  },
                  child: Text(
                    "다음 >",
                    style:
                    TextStyle(fontFamily: 'Dongle', fontSize: 30),
                  )),
            ),
          ],
        ));
  }


  Widget learningProgress() {
    double percent = sentIndex / widget.learningMaterialServer.sentences!.length;
    return Column(
      children: [
        Container(
          alignment: FractionalOffset(percent, 1 - percent),
          child: FractionallySizedBox(
              child: Image.asset('image/logo/logo.png',
                  width: 25, height: 25, fit: BoxFit.cover)),
        ),
        LinearPercentIndicator(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            percent: percent,
            lineHeight: 8,
            backgroundColor: Colors.black38,
            progressColor: Color(0XFF1086FE),
            width: MediaQuery.of(context).size.width)
      ],
    );
  }

  FutureBuilder<void> buildCameraFutureBuilder() {
    return FutureBuilder<void>(
      future: _initializeCameraControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Future가 완료되면, 프리뷰를 보여줍니다.
          return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/4+30,
              child: AspectRatio(
                  aspectRatio: _cameraController!.value.aspectRatio,
                  child: CameraPreview(_cameraController!)),
          );
        } else {
          // Otherwise, display a loading indicator.
          // 그렇지 않다면, 진행 표시기를 보여줍니다.
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Color(0xffFED40B),
      title: Text(
        '${widget.learningMaterialServer.subjectKor}',
        style:
        TextStyle(color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
      ),
      leading: IconButton(
          icon: Icon(Icons.close),
          color: const Color(0xff5a4c0c),
          onPressed: () {
            //videoController.pause();
            Navigator.pop(context);
            sentIndex = 0;
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
