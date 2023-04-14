import 'dart:async';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'LogIn/login.dart';
import 'myProvider.dart';

Future<void> main() async {
  //runApp 메소드 호출 전 Flutter SDK를 초기화 해야함.
  KakaoSdk.init(nativeAppKey: 'a7c9156b6c2c4aab0f535c89d618b305');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @overridef
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>Index_Provider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Capstone',
        home: LogIn(),
      ),
    );
  }
}
