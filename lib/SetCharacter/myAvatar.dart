import 'dart:io';
import 'package:flutter/material.dart';
import 'package:face_camera/face_camera.dart';

class MyAvatar extends StatefulWidget {
  const MyAvatar({Key? key}) : super(key: key);

  @override
  State<MyAvatar> createState() => _MyAvatarState();
}
class _MyAvatarState extends State<MyAvatar> {
  File? _capturedImage;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    WidgetsFlutterBinding.ensureInitialized();

    await FaceCamera.initialize();
  }
  @override
  Widget build(BuildContext context) {
    // 텍스트 데이터 전달
    // 화면 사이즈
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xffFED40B),
        title: Text(
          "내 얼굴을 찍어주세요",
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
      body: Builder(builder: (context) {
        if (_capturedImage != null) {
          return Center(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.file(
                  _capturedImage!,
                  width: double.maxFinite,
                  fit: BoxFit.fitWidth,
                ),
                ElevatedButton(
                    onPressed: () => setState(() => _capturedImage = null),
                    child: const Text(
                      'Capture Again',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w700),
                    ))
              ],
            ),
          );
        }
        return SmartFaceCamera(
            autoCapture: true,
            defaultCameraLens: CameraLens.front,
            onCapture: (File? image) {
              setState(() => _capturedImage = image);
            },
            onFaceDetected: (Face? face) {
              //Do something
            },
            messageBuilder: (context, face) {
              if (face == null) {
                return _message('내 얼굴을 카메라 안에 위치시키세요');
              }
              if (!face.wellPositioned) {
                return _message('내 얼굴을 사각형의 중간에 위치시키세요');
              }
              return const SizedBox.shrink();
            });
      }),
    );
  }
  Widget _message(String msg) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 15),
    child: Text(msg,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 14, height: 1.5, fontWeight: FontWeight.w400)),
  );
}
