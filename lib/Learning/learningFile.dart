import 'dart:async';
import 'package:capstone/Learning/learningMaterials.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:camera/camera.dart';


class LearningFile extends StatefulWidget {
  const LearningFile({Key? key, required this.learningMaterial})
      : super(key: key);

  final LearningMaterial learningMaterial;

  @override
  State<LearningFile> createState() => _LearningFileState();
}

class _LearningFileState extends State<LearningFile> {
  // 비디오 컨트롤러
  late VideoPlayerController videoController;
  String videoPath = learningMaterials.first.sentences.first.videoPath;

  // 카메라 기능
  late CameraController _cameraController;
  Future<void>? _initializeCameraControllerFuture;

  // 텍스트 애니메이션
  late List<String> words= widget.learningMaterial.sentences.first.sentence.split(" ").toList();
  late Timer timer;
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    videoController = VideoPlayerController.asset(videoPath);

    videoController.addListener(() {
      setState(() {});
    });
    videoController.setLooping(false); //영상 반복재생 금지
    videoController.initialize().then((_) => setState(() {}));
    //videoController.play();

    //카메라
    _initCamera();

    //텍스트
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      //activeIndex++;
      //if (activeIndex > words.length) activeIndex = 0;
      setState(() {});
    });
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    int frontIdx = 0;
    // 전면 카메라를 바로 켜야하기 때문에!
    for (int idx = 0; idx < cameras.length; idx++) {
      if (cameras[idx] == CameraLensDirection.front) {
        frontIdx = idx;
        break;
      }
    }
    _cameraController =
        CameraController(cameras[frontIdx], ResolutionPreset.veryHigh);
    _initializeCameraControllerFuture =
        _cameraController!.initialize().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // 위젯의 생명주기 종료시 컨트롤러 역시 해제시켜줍니다.
    _cameraController!.dispose();
    videoController.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        endDrawer: Drawer(),
        appBar: buildAppBar(context),
        body: Column(
          children: <Widget>[
            Container(
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
            Row(
              children: <Widget>[
                IconButton(
                  icon: Image(
                    image: AssetImage('image/logo/logo.png'),
                    width: 100,
                  ),
                  onPressed: () {
                    if (videoController.value.isPlaying) {
                      videoController.pause();
                    } else {
                      videoController.play();
                    }
                    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
                      activeIndex++;
                      //if (activeIndex > words.length) activeIndex = 0;
                      setState(() {});
                    });
                  },
                ),
                buildTextAnimation(context),
              ],
            ),
            Container(
                child: CircularProgressIndicator(
              backgroundColor: Colors.black,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            )),
            FutureBuilder<void>(
              future: _initializeCameraControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // Future가 완료되면, 프리뷰를 보여줍니다.
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: AspectRatio(
                          aspectRatio: 1 / _cameraController!.value.aspectRatio,
                          child: CameraPreview(_cameraController!)),
                    ),
                  );
                } else {
                  // Otherwise, display a loading indicator.
                  // 그렇지 않다면, 진행 표시기를 보여줍니다.
                  return Center(child: CircularProgressIndicator());
                }
              },
            )
          ],
        ));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Color(0xffFED40B),
      title: Text(
        '${widget.learningMaterial.subjectKor}',
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

  Widget buildTextAnimation(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: () {
          List<InlineSpan> spans = [];
          for (int i = 0; i < words.length; i++) {
            spans.add(TextSpan(
              text: words[i] + " ",
              style: i == activeIndex
                  ? const TextStyle( //highlight style
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
