import 'dart:async';
import 'package:capstone/Learning/File/learningMaterials.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  int _sentenceIdx = 0;

  // 카메라 기능
  late CameraController _cameraController;
  Future<void>? _initializeCameraControllerFuture;

  @override
  void initState() {
    super.initState();
    //카메라
    _initCamera();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        endDrawer: Drawer(),
        appBar: buildAppBar(context),
        body: buildBody(context));
  }

  Column buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        VideoAndTextScreen(
            sentenceData: widget.learningMaterial.sentences[_sentenceIdx]),
        Expanded(
          child: Image(
            image: AssetImage("image/logo/logo.png"),
            width: MediaQuery.of(context).size.width,
          ),
        ),
        //buildCameraFutureBuilder(),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: _sentenceIdx!=0? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextButton(
                    onPressed: () {
                      setState(() {
                        if(_sentenceIdx >= 0){
                          this._sentenceIdx--;
                        }
                      });
                    },
                    child: Text(
                      "< 이전",
                      style: TextStyle(fontFamily: 'Dongle', fontSize: 30),
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextButton(
                    onPressed: () {
                      setState(() {
                        this._sentenceIdx++;
                      });
                      if (this._sentenceIdx >=
                          widget.learningMaterial.sentences.length - 1) {
                        //학습 완료 시 보상
                        //지금은 학습 페이지 나가기로 설정
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      "다음 >",
                      style: TextStyle(fontFamily: 'Dongle', fontSize: 30),
                    )
                ),
              ),
            ],
          ):
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextButton(
                    onPressed: () {
                      setState(() {
                        this._sentenceIdx++;
                      });
                      if (this._sentenceIdx >=
                          widget.learningMaterial.sentences.length - 1) {
                        //학습 완료 시 보상
                        //지금은 학습 페이지 나가기로 설정
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      "다음 >",
                      style: TextStyle(fontFamily: 'Dongle', fontSize: 30),
                    )
                ),
              ),
            ],
          )
        ),
      ],
    );
  }

  FutureBuilder<void> buildCameraFutureBuilder() {
    return FutureBuilder<void>(
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
    );
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
            //videoController.pause();
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

class VideoAndTextScreen extends StatefulWidget {
  const VideoAndTextScreen({Key? key, required this.sentenceData})
      : super(key: key);

  final SentenceData sentenceData;

  @override
  State<VideoAndTextScreen> createState() => _VideoAndTextScreenState();
}

class _VideoAndTextScreenState extends State<VideoAndTextScreen> {
  // 비디오 컨트롤러
  late VideoPlayerController _videoController;
  late Future<void> _initializedController;
  late String videoPath;

  // 텍스트 애니메이션
  late List<String> words = widget.sentenceData.sentence.split(" ").toList();
  late Timer timer;
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    videoPath = widget.sentenceData.videoPath;
    _videoController = VideoPlayerController.asset(videoPath);
    _initializedController = _videoController.initialize();
    _videoController.setLooping(false); //영상 반복재생 금지

    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {});
    });
  }

  void dispose() {
    _videoController.dispose();
    timer.cancel();
    super.dispose();
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
                } else {
                  _videoController.play();
                }
                timer =
                    Timer.periodic(const Duration(milliseconds: 500), (timer) {
                  activeIndex++;
                  setState(() {});
                });
                if (activeIndex > words.length) activeIndex = 0;
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
                      //highlight style
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

class Index_Provider with ChangeNotifier {
  int _idx = 0;

  int get idx => _idx;

  void next() {
    _idx++;
    notifyListeners();
  }

  void prev() {
    _idx--;
    notifyListeners();
  }
}
