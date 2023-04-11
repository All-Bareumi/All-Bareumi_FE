import 'dart:async';

import 'package:flutter/material.dart';

class TextColorChange extends StatefulWidget {
  TextColorChange({Key? key, required this.text}) : super(key: key);

  final String text;
  @override
  _TextColorChangeState createState() => _TextColorChangeState();
}

class _TextColorChangeState extends State<TextColorChange> {
  final _normalStyle = TextStyle(
    color: Colors.black,
    fontSize: 24,
  );
  final _redStyle = TextStyle(
    color: Colors.red,
    fontSize: 24,
  );

  int redIndex = 0;

  late Timer timer;
  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        redIndex++;
        if (redIndex > 8) redIndex = 0;
      });
      print("rebuild");
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text.rich(
          TextSpan(children: [
            TextSpan(
              text: "hi ",
              style: redIndex == 0 ? _redStyle : _normalStyle,
            ),
            TextSpan(
              text: "ho ",
              style: redIndex == 1 ? _redStyle : _normalStyle,
            ),
            TextSpan(
              text: "mi  ",
              style: redIndex == 2 ? _redStyle : _normalStyle,
            ),
            TextSpan(
              text: "lo ",
              style: redIndex == 3 ? _redStyle : _normalStyle,
            ),
            TextSpan(
              text: "tu ",
              style: redIndex == 4 ? _redStyle : _normalStyle,
            ),
            TextSpan(
              text: "bo ",
              style: redIndex == 5 ? _redStyle : _normalStyle,
            ),
            TextSpan(
              text: "so ",
              style: redIndex == 6 ? _redStyle : _normalStyle,
            ),
            TextSpan(
              text: "ad ",
              style: redIndex == 7 ? _redStyle : _normalStyle,
            ),
            TextSpan(
              text: "wy ",
              style: redIndex == 8 ? _redStyle : _normalStyle,
            ),
          ]),
        ),
      ),
    );
  }
}