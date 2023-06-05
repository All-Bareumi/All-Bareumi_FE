import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'learningMaterialsServer.dart';

class VideoAndTextScreen extends StatefulWidget {
  VideoAndTextScreen({Key? key, required this.learningMaterial, required this.sentIndex})
      : super(key: key);

  Future<LearningMaterialServer>? learningMaterial;
  int sentIndex;

  @override
  State<VideoAndTextScreen> createState() => _VideoAndTextScreenState();
}


class _VideoAndTextScreenState extends State<VideoAndTextScreen> {
  // 비디오 컨트롤러
  late VideoPlayerController _videoController;
  late Future<void> _initializedController;
  late String videoPath;

  // 텍스트 애니메이션
  late List<String> words = widget.learningMaterial!.sentences?[widget.sentIndex]?.sentence?.split(" ")?.toList() ?? [];
  Timer? _animationTimer;
  int activeIndex = 0;

  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    videoPath = widget.learningMaterial?.sentences?[widget.sentIndex]?.videoPath ?? '';
    _videoController = VideoPlayerController.asset(videoPath);
    _initializedController = _videoController.initialize();
    _videoController.setLooping(false); //영상 반복재생 금지

    _animationTimer = Timer.periodic(const Duration(milliseconds: 500), (timer)
    {
      if (mounted && isPlaying) {
        activeIndex++;
        setState(() {
          if (activeIndex >= words.length) activeIndex = 0;
        });
      }
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
        videoPath = widget.learningMaterial?.sentences?[widget.sentIndex]?.videoPath ?? '';
        _videoController = VideoPlayerController.asset(videoPath);
        _initializedController = _videoController.initialize();
        _videoController.setLooping(false); //영상 반복재생 금지

        words = widget.learningMaterial.sentences?[widget.sentIndex]?.sentence?.split(" ")?.toList() ?? [];
        activeIndex = 0;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (_, snapshot) {
      return Column(children: <Widget>[
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
                }
                if(isPlaying){
                  if (_animationTimer?.isActive == false) {
                    // 실행 중인 타이머가 없으면 새로운 타이머 시작
                    _animationTimer = Timer.periodic(
                      Duration(milliseconds: (500).round()),
                          (timer) {
                        activeIndex++;
                        setState(() {
                          if (activeIndex >= words.length) activeIndex = 0;
                        });
                      },
                    );
                  }
                }
              },
            ),
            buildTextAnimation(context),
          ],
        ),
      ]);
    });
  }

  Widget buildTextAnimation(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: () {
          List<InlineSpan> spans = [];
          for (int i = 0; i < words.length; i++) {
            spans.add(TextSpan(
              text: words[i] + " ",
              style: i == activeIndex
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
    );
  }
}
