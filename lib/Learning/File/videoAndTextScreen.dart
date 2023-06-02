import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';
import 'learningMaterials.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:dio/dio.dart';


class VideoAndTextScreen extends StatefulWidget {
  VideoAndTextScreen(
      {Key? key, required this.learningMaterial, required this.sentIndex, required this.login_token})
      : super(key: key);

  final LearningMaterial learningMaterial;
  int sentIndex;
  final String login_token;

  @override
  State<VideoAndTextScreen> createState() => _VideoAndTextScreenState();
}

class _VideoAndTextScreenState extends State<VideoAndTextScreen> {
  // 비디오 컨트롤러
  late VideoPlayerController _videoController;
  late Future<void> _initializedController;
  late String videoPath;
  int iterCount = 0;
  int score= -1;
  final recorder = FlutterSoundRecorder();
  void initRecorder() async{
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted){
      throw 'Permission not granted';
    }
    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }
  Future startRecord() async{
    Directory tempDir = await getTemporaryDirectory(); // test를 위한 현재 경로
    print('${tempDir.path}');
    await recorder.startRecorder(toFile: '/audio');
  }

  Future stopRecord() async{
    final filePath = await recorder.stopRecorder();
    final file = File(filePath!);
    print('Recorded file path : $file');
    // 서버로 오디오 파일 넘기기
    //score = 3;
    score = await uploadData(widget.learningMaterial.sentences![widget.sentIndex].sentence, file);
    iterCount++;
  }
  //서버로 오디오 파일 넘기고 학습 분석 결과 받아오는 함수
  Future<int> uploadData(String sentence, File audioFile) async {
    try {
      Dio dio = Dio();
      FormData formData = FormData();

      // 문장 데이터 추가
      formData.fields.add(MapEntry('sentence', sentence));

      // 로그인 토큰 추가
      dio.options.headers['Authorization'] = 'Bearer $widget.login_token';

      // 녹음 파일 추가
      formData.files.add(MapEntry(
          'audio',
          await MultipartFile.fromFile(
            audioFile.path,
            filename: audioFile.path.split('/').last,
          )));

      var response = await dio.post(
        'http://localhost:8001/api/user',//경로 설정하기
        data: formData,
      );

      if (response.statusCode == 200) {
        // 업로드 성공
        print('Data uploaded successfully');

        // 서버에서 반환된 int 값 리턴
        return response.data['score'] as int;
      } else {
        // 업로드 실패
        print('Failed to upload data. Error: ${response.statusCode}');
        return -1; // 예외 상황을 나타내는 음수 값이나 적절한 기본값으로 대체해주세요.
      }
    } catch (e) {
      // 오류 처리
      print('Error during data upload: $e');
      return -1; // 예외 상황을 나타내는 음수 값이나 적절한 기본값으로 대체해주세요.
    }
  }

  // 텍스트 애니메이션
  late List<String> words = widget
          .learningMaterial.sentences?[widget.sentIndex]?.sentence
          ?.split(" ")
          ?.toList() ??
      [];
  Timer? _animationTimer;
  int activeIndex = 0;

  bool isPlaying = false;
  void initVideo(){
    videoPath = widget.learningMaterial?.sentences?[widget.sentIndex]?.videoPath ?? '';
    _videoController = VideoPlayerController.asset(videoPath);
    _initializedController = _videoController.initialize();
    _videoController.setLooping(false); //영상 반복재생 금지
  }
  @override
  void initState() {
    super.initState();
    initVideo();
    _animationTimer =
        Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {});
    });
    initRecorder();
    score = -1;
  }

  void dispose() {
    _videoController.dispose();
    _animationTimer?.cancel();
    if (recorder!=null){
      recorder.closeRecorder();
    }
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
        activeIndex = -1;
        iterCount = 0;
        score = -1;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (_, snapshot) {
      //print(iterCount);
      return Column(children: <Widget>[
        buildGuideLineRow(),
        Container(
          child: AspectRatio(
            aspectRatio: _videoController.value.aspectRatio,
            child: VideoPlayer(_videoController),
          ),
        ),
        buildTextAnimationRow(context),
        buildAudioAndStarScoreRow()
      ]);
    });
  }

  Row buildAudioAndStarScoreRow() {
    if (iterCount >= 1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  if (recorder.isRecording) {
                    await stopRecord();
                    setState(() {});
                  } else {
                    await startRecord();
                    setState(() {});
                  }
                },
                icon: Icon(
                  recorder.isRecording ? Icons.stop : Icons.mic,
                  size: 30,
                  color: Color(0xff1AB846),
                ),
              ),
              StreamBuilder<RecordingDisposition>(
                builder: (context, snapshot) {
                  final duration =
                  snapshot.hasData ? snapshot.data!.duration : Duration.zero;
                  String twoDigits(int n) => n.toString().padLeft(2, '0');
                  final twoDigitMinutes =
                  twoDigits(duration.inMinutes.remainder(60));
                  final twoDigitSeconds =
                  twoDigits(duration.inSeconds.remainder(60));
                  return Text(
                    '$twoDigitMinutes:$twoDigitSeconds',
                    style: TextStyle(fontSize: 30, fontFamily: 'Dongle'),
                  );
                },
                stream: recorder.onProgress,
              ),
            ],
          ),
          if (score != null && score >= 0) StarRatingWidget(score: score),
        ],
      );
    } else {
      return Row();
    }
  }


  Row buildGuideLineRow() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iterCount == 0)
            Text(
              "입모양을 보고 소리를 들어보아요",
              style: TextStyle(fontFamily: 'Dongle', fontSize: 35),
            ),
          if (iterCount == 1)
            Text(
              "내 입모양을 보며 따라 읽어보아요",
              style: TextStyle(fontFamily: 'Dongle', fontSize: 35),
            ),
          if (iterCount == 2)
            Text(
              "잘했어요. 다음으로 넘어가볼까요?",
              style: TextStyle(fontFamily: 'Dongle', fontSize: 35),
            ),
        ],
      );
  }

  Row buildTextAnimationRow(BuildContext context) {
    return Row(
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
      );
  }

  void startTextAnimation() {
    _animationTimer =
        Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        activeIndex++;
        if (activeIndex >= words.length) {
          isPlaying = false;
          activeIndex = 0;
          _animationTimer?.cancel();
          iterCount = 1;
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

class StarRatingWidget extends StatelessWidget {
  final int score;

  const StarRatingWidget({required this.score});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Row(
        children: List.generate(
          5,
              (index) => Icon(
            index < score ? Icons.star : Icons.star_border,
            color: Color(0xffFED40B),
            size: 20,
          ),
        ),
      ),
    );
  }
}
