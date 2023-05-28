import 'dart:async';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'LogIn/login.dart';

Future<void> main() async {
  //runApp 메소드 호출 전 Flutter SDK를 초기화 해야함.
  KakaoSdk.init(nativeAppKey: 'a7c9156b6c2c4aab0f535c89d618b305', javaScriptAppKey: 'f018c1e6f7f6089813b1b9e9002de712');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'All-Bareumi',
        home: LogIn(),
      );
  }
}

// MultiProvider(
// providers: [
// //ChangeNotifierProvider(create: (_)=>SentenceIndexProvider()),
// ],
// child: MaterialApp(
// debugShowCheckedModeBanner: false,
// title: 'All-Bareumi',
// home: LogIn(),
// );
// )