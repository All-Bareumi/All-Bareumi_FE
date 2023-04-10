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
  late Future<void> _initializeVideoPlayerFuture;

  String videoPath = 'video/temp_anna.mp4';

  @override
  void initState() {
    super.initState();
    videoController = VideoPlayerController.asset(videoPath);
    _initializeVideoPlayerFuture = videoController.initialize();

    videoController.setLooping(false);

    super.initState();
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
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return AspectRatio(
                        aspectRatio: videoController.value.aspectRatio,
                        child: VideoPlayer(videoController));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (videoController.value.isPlaying) {
                      videoController.pause();
                    } else {
                      videoController.play();
                    }
                  },
                  icon: Icon(
                    videoController.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    size: 50,
                    color: Color(0xffFED40B),
                  ),
                ),
                SizedBox(width: 10,),
                Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: Text(
                    "입모양을 보고 문장을 따라 읽어보세요!",
                    style: TextStyle(fontFamily: 'Dongle', fontSize: 35),
                  ),
                ),
              ],
            )
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
