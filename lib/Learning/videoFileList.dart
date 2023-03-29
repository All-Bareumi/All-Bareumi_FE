import 'package:flutter/material.dart';

class LearningVideo extends StatefulWidget {
  const LearningVideo({Key? key}) : super(key: key);

  @override
  State<LearningVideo> createState() => _LearningVideoState();
}

class _LearningVideoState extends State<LearningVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFED40B),
      endDrawer: Drawer(),
      appBar: buildAppBar(context),
    );
  }
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Color(0xffFED40B),
      title: Text(
        '홈',
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
