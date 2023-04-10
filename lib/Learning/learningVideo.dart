import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'package:video_uploader/video_uploader.dart';

class LearningVideo extends StatefulWidget {
  const LearningVideo({Key? key, required this.fileName}) : super(key: key);

  final String fileName;

  @override
  State<LearningVideo> createState() => _LearningVideoState();
}

class _LearningVideoState extends State<LearningVideo> {
  late VideoPlayerController videoController;
  String videoPath = 'video/temp_anna.mp4';

  @override
  void initState() {
    super.initState();
    videoController = VideoPlayerController.asset(videoPath);

    videoController.addListener(() {
      setState(() {});
    });
    videoController.setLooping(false);
    videoController.initialize().then((_) => setState(() {}));
    videoController.play();
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: Drawer(),
      appBar: buildAppBar(context),
      body: Column(children: <Widget>[
        Center(
          child: InkWell(
            onTap: () {
              if (videoController.value.isPlaying) {
                videoController.pause();
              } else {
                videoController.play();
              }
            },
            child: AspectRatio(
              aspectRatio: videoController.value.aspectRatio,
              child: VideoPlayer(videoController),
            ),
          ),
        ),
        Text("입모양을 보고 문장을 따라 읽어보세요!", style: TextStyle(fontFamily: 'Dongle', fontSize: 40),)
      ]),
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
