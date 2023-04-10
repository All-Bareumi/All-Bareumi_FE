import 'package:flutter/material.dart';

class LearningFile extends StatefulWidget {
  const LearningFile({Key? key, required this.fileName}) : super(key: key);

  final String fileName;

  @override
  State<LearningFile> createState() => _LearningFileState();
}

class _LearningFileState extends State<LearningFile> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: Drawer(),
      appBar: buildAppBar(context),
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
