import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

class LearningFile extends StatefulWidget {
  const LearningFile({Key? key, required this.fileName}) : super(key: key);

  final String fileName;

  @override
  State<LearningFile> createState() => _LearningFileState();
}

class _LearningFileState extends State<LearningFile> {
  late VideoPlayerController controller;
  //String videoUrl = 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
  String videoPath = "video/temp_anna.mp4";

  // 카메라 기능
  CameraController? _cameraController;
  Future<void>? _initCameraControllerFuture;
  int cameraIndex = 0;

  bool isCapture = false;
  File? captureImage;

  //따로
  bool _cameraInitialized = false;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset(videoPath);

    controller.addListener(() {
      setState(() {});
    });
    controller.setLooping(true);
    controller.initialize().then((_) => setState(() {}));
    controller.play();

    //카메라
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    // 전면 카메라 사용
    CameraDescription frontCamera;
    for (var camera in cameras) {
      if (camera.lensDirection == CameraLensDirection.front) {
        cameraIndex = camera.lensDirection.index; // 이게 맞을진 몰겠음
        break;
      }
    }
    _cameraController =
    CameraController(cameras[cameraIndex], ResolutionPreset.veryHigh);
    _initCameraControllerFuture = _cameraController!.initialize().then((value) {
      setState(() => _cameraInitialized = true);
    });
  }

  @override
  void dispose() {
    // 위젯의 생명주기 종료시 컨트롤러 역시 해제시켜줍니다.
    _cameraController!.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        endDrawer: Drawer(),
        appBar: buildAppBar(context),
        body: _cameraInitialized ?
        Column(
          children: <Widget>[
            Container(
              child: InkWell(
                onTap: () {
                  if (controller.value.isPlaying) {
                    controller.pause();
                  } else {
                    controller.play();
                  }
                },
                child: AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                ),
              ),
            ),
            // Container(
            //     child: CircularProgressIndicator(
            //       backgroundColor: Colors.black,
            //       valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            //     )
            // ),
            // SizedBox(
            //     child: CameraPreview(_cameraController)
            // ),

          ],
        ) : Container(
          child: InkWell(
            onTap: () {
              if (controller.value.isPlaying) {
                controller.pause();
              } else {
                controller.play();
              }
            },
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            ),
          ),
        ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Color(0xffFED40B),
      title: Text(
        '${widget.fileName}',
        style:
        TextStyle(color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
      ),
      leading: IconButton(
          icon: Icon(Icons.close),
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
