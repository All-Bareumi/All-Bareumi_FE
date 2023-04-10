import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key, required this.text}) : super(key: key);

  final String text;
  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {

  // 카메라 기능
  CameraController? _cameraController;
  Future<void>? _initCameraControllerFuture;
  int cameraIndex = 0;

  bool isCapture = false;
  File? captureImage;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    _cameraController =
        new CameraController(cameras[cameraIndex], ResolutionPreset.veryHigh);
    _initCameraControllerFuture = _cameraController!.initialize().then((value) {
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
    // 텍스트 데이터 전달
    String text = widget.text;
    // 화면 사이즈
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xffFED40B),
        title: Text(
          text,
          style: TextStyle(
              color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
        ),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            color: const Color(0xff5a4c0c),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),

      backgroundColor: Colors.black,
      body: isCapture
          ? Column(
              children: [
                /// 촬영 된 이미지 출력
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Container(
                    width: size.width,
                    height: size.height /2 ,
                    child: ClipRect(
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: SizedBox(
                          width: size.width,
                          child: AspectRatio(
                            aspectRatio:
                                1 / _cameraController!.value.aspectRatio,
                            child: Container(
                              width: size.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: MemoryImage(
                                    captureImage!.readAsBytesSync()),
                              )),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: InkWell(
                    onTap: () {
                      /// 재촬영 선택시 카메라 삭제 및 상태 변경
                      captureImage!.delete();
                      captureImage = null;
                      setState(() {
                        isCapture = false;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            "다시 찍기",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: FutureBuilder<void>(
                    future: _initCameraControllerFuture,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return SizedBox(
                          width: size.width,
                          height: size.width,
                          child: ClipRect(
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: SizedBox(
                                width: size.width,
                                child: AspectRatio(
                                    aspectRatio: 1 /
                                        _cameraController!.value.aspectRatio,
                                    child: CameraPreview(_cameraController!)),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 48.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            try {
                              await _cameraController!
                                  .takePicture()
                                  .then((value) {
                                captureImage = File(value.path);
                              });

                              /// 화면 상태 변경 및 이미지 저장
                              setState(() {
                                isCapture = true;
                              });
                            } catch (e) {
                              print("$e");
                            }
                          },
                          child: Container(
                            height: 80.0,
                            width: 80.0,
                            padding: const EdgeInsets.all(1.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.black, width: 1.0),
                              color: Colors.white,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.black, width: 3.0),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () async {
                              /// 후면 카메라 <-> 전면 카메라 변경
                              cameraIndex = cameraIndex == 0 ? 1 : 0;
                              await _initCamera();
                            },
                            icon: Icon(
                              Icons.flip_camera_ios,
                              color: Colors.white,
                              size: 34.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
