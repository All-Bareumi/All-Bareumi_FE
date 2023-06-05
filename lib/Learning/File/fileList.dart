// import 'dart:convert';
// import 'package:capstone/Learning/File/learningFile.dart';
// import 'package:flutter/material.dart';
// import 'package:capstone/Learning/File/learningMaterials.dart';
// import 'package:http/http.dart' as http;
// import '../../userDrawer/loadingDrawer.dart';
// import '../LearningReport/reoportContent.dart';
//
//
//
// class FileList extends StatefulWidget {
//   const FileList(
//       {Key? key, required this.login_token, required this.selectedCharacter})
//       : super(key: key);
//   final String login_token;
//   final String selectedCharacter;
//
//   @override
//   State<FileList> createState() => _FileListState();
// }
//
// class _FileListState extends State<FileList> {
//   bool showLearningReportPopup = true;
//   ReportContent? reportContent;
//
//   Future<bool> fetchServerResponse() async {
//     final url =
//         Uri.parse('http://localhost:8001/api/'); // 오늘의 학습량 목표를 도달했는지 확인하기 위한 서버
//
//     try {
//       final response = await http.get(url);
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final boolValue = data[
//             'goalAchived']; // Replace 'response' with the actual key in your server response
//         return boolValue;
//       } else {
//         // Handle error case if the request was not successful
//         throw Exception('Failed to fetch server response');
//       }
//     } catch (e) {
//       // Handle network or other runtime errors
//       throw Exception('Failed to connect to the server');
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     fetchServerResponse().then((bool serverResponse) {
//       setState(() {
//         showLearningReportPopup = serverResponse;
//       });
//     }).catchError((error) {
//       print('Failed to fetch server response: $error');
//       // Handle the error case accordingly
//     });
//     if (showLearningReportPopup) {
//       //fetchData();
//     }
//   }
//
//   Future<void> fetchData() async {
//     // 서버에서 팝업 내용 가져오기
//     var response =
//         await http.get(Uri.parse('http://localhost:8001/api/popup/content'));
//     if (response.statusCode == 200) {
//       // 팝업 내용 가져오기 성공
//       var data = jsonDecode(response.body);
//       setState(() {
//         reportContent = ReportContent(
//           title: data['title'],
//           goodSentence: data['goodSentence'],
//           badSentence: data['badSentence'],
//           score: data['score'],
//         );
//       });
//     } else {
//       // 팝업 내용 가져오기 실패
//       setState(() {
//         reportContent = null;
//       });
//     }
//   }
//
//   void showReport(BuildContext context) {
//     // Assuming reportContent is a variable or object containing the report data
//     // if (reportContent == null) {
//     //   return;}
//
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     '오늘의 학습 리포트',
//                     style: TextStyle(fontFamily: 'Dongle', fontSize: 40),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   children: [
//                     Text(
//                       '가장 잘 말한 문장',
//                       style: TextStyle(fontFamily: 'Dongle', fontSize: 30),
//                     ),
//                     Row(
//                       children: List.generate(5, (index) {
//                         return Icon(Icons.star, color: Colors.yellow);
//                       }),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Icon(Icons.arrow_right_outlined),
//                     Text(
//                       'Good sentence',
//                       // '${reportContent!.goodSentence}',
//                       style: TextStyle(fontFamily: 'Dongle', fontSize: 30),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   children: [
//                     Text(
//                       '가장 어려웠던 문장',
//                       style: TextStyle(fontFamily: 'Dongle', fontSize: 30),
//                     ),
//                     Row(
//                       children: List.generate(5, (index) {
//                         return Icon(Icons.star, color: Colors.yellow);
//                       }),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Icon(Icons.arrow_right_outlined),
//                     Text(
//                       'Difficult sentence',
//                       // '${reportContent!.difficultSentence}',
//                       style: TextStyle(fontFamily: 'Dongle', fontSize: 30),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   children: [
//                     Text(
//                       '오늘도 짱!',
//                       style: TextStyle(fontFamily: 'Dongle', fontSize: 30),
//                     ),
//                     Row(
//                       children: List.generate(5, (index) {
//                         return Icon(Icons.star, color: Colors.yellow);
//                       }),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 TextButton(
//                   child: Text(
//                     '닫기',
//                     style: TextStyle(fontSize: 30, fontFamily: 'Dongle'),
//                   ),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 SizedBox(height: 20),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (showLearningReportPopup) {
//       WidgetsBinding.instance!.addPostFrameCallback((_) {
//         showReport(context);
//       });
//     }
//     return Scaffold(
//         backgroundColor: Color(0xffFED40B),
//         endDrawer: LoadingDrawer(login_token: widget.login_token),
//         appBar: buildAppBar(context),
//         body: Stack(
//           children: <Widget>[
//             Column(children: <Widget>[
//               SizedBox(height: MediaQuery.of(context).size.height / 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Image(image: AssetImage("image/design/WhiteEllipseTop.png")),
//                 ],
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 4),
//               Row(
//                 children: [
//                   //SizedBox(width: 30,),
//                   Image(
//                       image: AssetImage("image/design/WhiteEllipseBottom.png")),
//                 ],
//               )
//             ]),
//             GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                 ),
//                 itemCount: learningMaterials.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Card(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20.0),
//                         ),
//                         elevation: 2,
//                         color: Color(0xfffffBDE),
//                         child: InkWell(
//                           onTap: () {
//                             showModalBottomSheet(
//                                 context: context,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(30),
//                                 ),
//                                 builder: (BuildContext context) {
//                                   return InkWell(
//                                     onTap: () {
//                                       Navigator.of(context).push(_createRoute(
//                                           learningMaterials[index],
//                                           widget.login_token));
//                                     },
//                                     child: Container(
//                                       height: 200,
//                                       //color: Colors.transparent,
//                                       child: Text(
//                                         '학습 시작하기',
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 60,
//                                             fontFamily: 'Dongle'),
//                                       ),
//                                       decoration: const BoxDecoration(
//                                         borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(30),
//                                           topRight: Radius.circular(30),
//                                         ),
//                                         color: Color(0XFFED5555),
//                                       ),
//                                     ),
//                                   );
//                                 });
//                           },
//                           child: Column(
//                             children: <Widget>[
//                               Text(
//                                 learningMaterials[index].subjectKor,
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     fontSize: 35,
//                                     fontFamily: 'Dongle',
//                                     color: Colors.black),
//                               ),
//                               Image(
//                                   image: AssetImage(
//                                       learningMaterials[index].imgPath),
//                                   width: MediaQuery.of(context).size.width / 4),
//                             ],
//                           ),
//                         )),
//                   );
//                 }),
//           ],
//         ));
//   }
//
//   AppBar buildAppBar(BuildContext context) {
//     return AppBar(
//       elevation: 0.0,
//       backgroundColor: Color(0xffFED40B),
//       title: Text(
//         '학습 자료 목록',
//         style:
//             TextStyle(color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
//       ),
//       leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios_new),
//           color: const Color(0xff5a4c0c),
//           onPressed: () {
//             Navigator.pop(context);
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
//
// Route _createRoute(LearningMaterial learningMaterial, String login_token) {
//   return PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) => new LearningFile(
//             learningMaterial: learningMaterial,
//             login_token: login_token,
//           ),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         var begin = Offset(0.0, 1.0);
//         var end = Offset.zero;
//         var curve = Curves.ease;
//         var curveTween = CurveTween(curve: curve);
//
//         var tween = Tween(begin: begin, end: end).chain(curveTween);
//         var offsetAnimation = animation.drive(tween);
//         return SlideTransition(
//           position: offsetAnimation,
//           child: child,
//         );
//       });
// }
