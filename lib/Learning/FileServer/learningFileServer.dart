// import 'dart:async';
// import 'dart:convert';
// import 'package:capstone/Learning/File/learningMaterials.dart';
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'videoAndTextScreenServer.dart';
// import 'package:percent_indicator/percent_indicator.dart';
// import 'package:http/http.dart' as http;
//
// Future<LearningMaterial> fetchLearningMaterial(String subject) async {
//   var url = '$subject';
//   final response = await http.get(Uri.parse(url));
//
//   if (response.statusCode == 200) {
//     //만약 서버가 ok응답을 반환하면, json을 파싱합니다
//     print('응답 완료');
//     print(json.decode(response.body));
//     return LearningMaterial.fromJson(json.decode(response.body));
//   } else {
//     //만약 응답이 ok가 아니면 에러를 던집니다.
//     throw Exception('정보를 불러오는데 실패했습니다');
//   }
// }
//
//
// class LearningFileServer extends StatefulWidget {
//   const LearningFileServer({Key? key, required this.learningFileName})
//       : super(key: key);
//
//   final String learningFileName;
//
//   @override
//   State<LearningFileServer> createState() => _LearningFileServerState();
// }
//
// class _LearningFileServerState extends State<LearningFileServer> {
//   // 카메라 기능
//   late CameraController _cameraController;
//   Future<void>? _initializeCameraControllerFuture;
//   Future<LearningMaterial>? learningMaterial;
//   int sentIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     //카메라
//     _initCamera();
//     learningMaterial = fetchLearningMaterial(widget.learningFileName);
//   }
//
//   Future<void> _initCamera() async {
//     final cameras = await availableCameras();
//     int frontIdx = 0;
//     // 전면 카메라를 바로 켜야하기 때문에!
//     for (int idx = 0; idx < cameras.length; idx++) {
//       if (cameras[idx] == CameraLensDirection.front) {
//         frontIdx = idx;
//         break;
//       }
//     }
//     _cameraController =
//         CameraController(cameras[frontIdx], ResolutionPreset.veryHigh);
//     _initializeCameraControllerFuture =
//         _cameraController!.initialize().then((value) {
//           setState(() {});
//         });
//   }
//
//   @override
//   void dispose() {
//     // 위젯의 생명주기 종료시 컨트롤러 역시 해제시켜줍니다.
//     _cameraController!.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       endDrawer: Drawer(),
//       appBar: buildAppBar(context),
//       body: Center(
//     child: FutureBuilder<LearningMaterial>(
//     //통신데이터 가져오기
//     future: learningMaterial,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return buildBody(context, snapshot);
//         } else if (snapshot.hasError) {
//           return Text("${snapshot.error}에러!!");
//         }
//         return CircularProgressIndicator();
//       },
//     ),
//     ));
//   }
//
//   Column buildBody(BuildContext context, snapshot) {
//     return Column(
//       children: <Widget>[
//         // 이때 서버에서 받아온 데이터를 전달한다.
//         // learningMaterial은 Future 객체
//         VideoAndTextScreen(
//           learningMaterial: learningMaterial,
//           sentIndex: sentIndex,
//         ),
//         Expanded(
//           child: Image(
//             image: AssetImage("image/logo/logo.png"),
//             width: MediaQuery
//                 .of(context)
//                 .size
//                 .width,
//           ),
//         ),
//         learningProgress(),
//         //buildCameraFutureBuilder(),
//         Padding(
//             padding: const EdgeInsets.only(right: 8.0),
//             child: sentIndex != 0
//                 ? Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 8.0),
//                   child: TextButton(
//                       onPressed: () {
//                         setState(() {
//                           if (sentIndex > 0) {
//                             sentIndex--;
//                           }
//                         });
//                       },
//                       child: Text(
//                         "< 이전",
//                         style:
//                         TextStyle(fontFamily: 'Dongle', fontSize: 30),
//                       )),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(right: 8.0),
//                   child: TextButton(
//                       onPressed: () {
//                         setState(() {
//                           if (sentIndex >=
//                               (widget.learningMaterial.sentences
//                                   ?.length ??
//                                   1) -
//                                   1) {
//                             Navigator.pop(context);
//                             sentIndex = 0;
//                           } else {
//                             sentIndex++;
//                           }
//                         });
//                       },
//                       child: Text(
//                         "다음 >",
//                         style:
//                         TextStyle(fontFamily: 'Dongle', fontSize: 30),
//                       )),
//                 ),
//               ],
//             )
//                 : Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(right: 8.0),
//                   child: TextButton(
//                       onPressed: () {
//                         setState(() {
//                           if (sentIndex >=
//                               (widget.learningMaterial.sentences
//                                   ?.length ??
//                                   0) -
//                                   1) {
//                             Navigator.pop(context);
//                           } else {
//                             sentIndex++;
//                           }
//                         });
//                       },
//                       child: Text(
//                         "다음 >",
//                         style:
//                         TextStyle(fontFamily: 'Dongle', fontSize: 30),
//                       )),
//                 ),
//               ],
//             )),
//       ],
//     );
//   }
//
//   Widget learningProgress() {
//     double percent = sentIndex / widget.learningMaterial.sentences!.length;
//     return Column(
//       children: [
//         Container(
//           alignment: FractionalOffset(percent, 1 - percent),
//           child: FractionallySizedBox(
//               child: Image.asset('image/logo/logo.png',
//                   width: 30, height: 30, fit: BoxFit.cover)),
//         ),
//         LinearPercentIndicator(
//             padding: EdgeInsets.zero,
//             percent: percent,
//             lineHeight: 10,
//             backgroundColor: Colors.black38,
//             progressColor: Colors.indigo.shade900,
//             width: MediaQuery
//                 .of(context)
//                 .size
//                 .width)
//       ],
//     );
//   }
//
//   FutureBuilder<void> buildCameraFutureBuilder() {
//     return FutureBuilder<void>(
//       future: _initializeCameraControllerFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           // Future가 완료되면, 프리뷰를 보여줍니다.
//           return SizedBox(
//             width: MediaQuery
//                 .of(context)
//                 .size
//                 .width,
//             height: MediaQuery
//                 .of(context)
//                 .size
//                 .width,
//             child: SizedBox(
//               width: MediaQuery
//                   .of(context)
//                   .size
//                   .width,
//               child: AspectRatio(
//                   aspectRatio: 1 / _cameraController!.value.aspectRatio,
//                   child: CameraPreview(_cameraController!)),
//             ),
//           );
//         } else {
//           // Otherwise, display a loading indicator.
//           // 그렇지 않다면, 진행 표시기를 보여줍니다.
//           return Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }
//
//   AppBar buildAppBar(BuildContext context) {
//     return AppBar(
//       elevation: 0.0,
//       backgroundColor: Color(0xffFED40B),
//       title: Text(
//         '${widget.learningMaterial.subjectKor}',
//         style:
//         TextStyle(color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
//       ),
//       leading: IconButton(
//           icon: Icon(Icons.close),
//           color: const Color(0xff5a4c0c),
//           onPressed: () {
//             //videoController.pause();
//             Navigator.pop(context);
//             sentIndex = 0;
//           }),
//       actions: <Widget>[
//         Builder(builder: (context) {
//           return IconButton(
//             icon: Image(
//               image: AssetImage('image/logo/logo.png'),
//               width: 60,
//             ),
//             onPressed: () => Scaffold.of(context).openEndDrawer(),
//           );
//         })
//       ],
//     );
//   }
// }
