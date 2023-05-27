import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'learningMaterials.dart';

class VideoAndTextScreen extends StatefulWidget {
  VideoAndTextScreen(
      {Key? key, required this.learningMaterial, required this.sentIndex})
      : super(key: key);

  final LearningMaterial learningMaterial;
  int sentIndex;

  @override
  State<VideoAndTextScreen> createState() => _VideoAndTextScreenState();
}

class _VideoAndTextScreenState extends State<VideoAndTextScreen> {
  // 비디오 컨트롤러
  late VideoPlayerController _videoController;
  late Future<void> _initializedController;
  late String videoPath;
  String guideText = "입모양을 보고 소리를 들어보아요";

  // 텍스트 애니메이션
  late List<String> words = widget
          .learningMaterial.sentences?[widget.sentIndex]?.sentence
          ?.split(" ")
          ?.toList() ??
      [];
  Timer? _animationTimer;
  int activeIndex = 0;

  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    videoPath =
        widget.learningMaterial?.sentences?[widget.sentIndex]?.videoPath ?? '';
    _videoController = VideoPlayerController.asset(videoPath);
    _initializedController = _videoController.initialize();
    _videoController.setLooping(false); //영상 반복재생 금지
    _animationTimer =
        Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {});
    });
  }

  void dispose() {
    _videoController.dispose();
    _animationTimer?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant VideoAndTextScreen oldWidget) {
    if (widget.sentIndex != oldWidget.sentIndex) {
      setState(() {
        videoPath =
            widget.learningMaterial?.sentences?[widget.sentIndex]?.videoPath ??
                '';
        _videoController = VideoPlayerController.asset(videoPath);
        _initializedController = _videoController.initialize();
        _videoController.setLooping(false); //영상 반복재생 금지

        words = widget.learningMaterial.sentences?[widget.sentIndex]?.sentence
                ?.split(" ")
                ?.toList() ??
            [];
        activeIndex = -1;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (_, snapshot) {
      return Column(children: <Widget>[
        Text(
          '$guideText',
          style: TextStyle(fontFamily: 'Dongle', fontSize: 35),
        ),
        Container(
          child: AspectRatio(
            aspectRatio: _videoController.value.aspectRatio,
            child: VideoPlayer(_videoController),
          ),
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: Image(
                image: AssetImage('image/logo/logo.png'),
                width: 100,
              ),
              onPressed: () {
                if (_videoController.value.isPlaying) {
                  _videoController.pause();
                  isPlaying = false;
                  _animationTimer?.cancel();
                } else {
                  _videoController.play();
                  isPlaying = true;
                  startTextAnimation();
                }
                setState(() {});
              },
            ),
            buildTextAnimation(context),
          ],
        ),
      ]);
    });
  }

  void startTextAnimation() {
    _animationTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        activeIndex++;
        if (activeIndex >= words.length) {
          isPlaying = false;
          activeIndex = 0;
          _animationTimer?.cancel();
        }
      });
    });
  }


  Widget buildTextAnimation(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: RichText(
        text: TextSpan(
          children: () {
            List<InlineSpan> spans = [];
            for (int i = 0; i < words.length; i++) {
              spans.add(TextSpan(
                text: words[i] + " ",
                style: i <= activeIndex
                    ? const TextStyle(
                        // highlight style
                        color: Colors.orange,
                        fontSize: 35,
                        fontFamily: 'Dongle',
                      )
                    : TextStyle(
                        color: Colors.grey.shade300,
                        fontSize: 35,
                        fontFamily: 'Dongle',
                      ),
              ));
            }
            return spans;
          }(),
        ),
      ),
    );
  }
}
