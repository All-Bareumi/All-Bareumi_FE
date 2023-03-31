import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'LogIn/login.dart';

Future<void> main() async {
  // 디바이스에서 이용가능한 카메라 목록을 받아옵니다.
  final cameras = await availableCameras();

  // 이용가능한 카메라 목록에서 특정 카메라를 얻습니다.
  final firstCamera = cameras.first;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Capstone',
      home: LogIn(
      ),
    );
  }
}

