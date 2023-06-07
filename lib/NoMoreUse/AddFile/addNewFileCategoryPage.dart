// import 'dart:convert';
// import 'dart:io';
//
// import 'package:capstone/AddFile/addNewFilePage.dart';
// import 'package:flutter/material.dart';
// import 'package:capstone/Learning/File/learningMaterials.dart';
// import '../../userDrawer/loadingDrawer.dart';
// import '../Learning/FileServer/fileListServer.dart';
// import '../Learning/FileServer/learningMaterialsServer.dart';
// import 'addTextPage.dart';
// import 'package:http/http.dart' as http;
//
// class AddNewFileCategoryPage extends StatefulWidget {
//   const AddNewFileCategoryPage(
//       {Key? key, required this.login_token, required this.selectedCharacter})
//       : super(key: key);
//   final String login_token;
//   final String selectedCharacter;
//
//   @override
//   State<AddNewFileCategoryPage> createState() => _AddNewFileCategoryPageState();
// }
//
// class _AddNewFileCategoryPageState extends State<AddNewFileCategoryPage> {
//   TextEditingController _textFieldController = TextEditingController();
//   List<LearningMaterialServer> learningMaterials = [];
//
//   @override
//   void initState(){
//     super.initState();
//     fetchLearningMaterials(widget.selectedCharacter).then((materials) {
//       setState(() {
//         learningMaterials = materials;
//       });
//     }).catchError((error) {
//       // 에러 처리
//       print(error);
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Color(0xffFED40B),
//         endDrawer: LoadingDrawer(login_token: widget.login_token),
//         appBar: buildAppBar(context),
//         body: buildStackBody(context),
//         floatingActionButton: buildFloatingActionButton(context),
//     );
//   }
//
//   FloatingActionButton buildFloatingActionButton(BuildContext context) {
//     return FloatingActionButton(
//           onPressed: () {
//             showDialog(
//                 context: context,
//                 builder: (context) => AlertDialog(
//                   title: Text(
//                     '추가할 학습 자료의 제목을\n입력하세요.',
//                     style: TextStyle(
//                         fontSize: 35,
//                         fontFamily: 'Dongle',
//                         color: Colors.black),
//                   ),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0)),
//                   content: TextField(
//                     onChanged: (value) {},
//                     controller: _textFieldController,
//                     decoration: InputDecoration(hintText: "제목"),
//                   ),
//                   actions: <Widget>[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         TextButton(
//                           onPressed: () async{
//                             String textSubject = _textFieldController.text;
//                             try {
//                               var response = await http.post(
//                                 Uri.parse(
//                                   'http://10.210.60.33:8001/api/learning/sentences/category', // 추가되는 문장 경로 추가하기
//                                 ),
//                                 body: jsonEncode({
//                                   'category': textSubject,
//                                 }),
//                                 headers: {
//                                   "Content-Type": "application/json",
//                                   HttpHeaders.authorizationHeader:
//                                   'Bearer ${widget.login_token}'
//                                 },
//                               );
//                               print(response.body);
//
//                             } catch (e) {
//                               print(e);
//
//                             }
//                             Navigator.of(context).pop();
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => AddNewFilePage(
//                                       textSubject:
//                                       textSubject,
//                                       login_token: widget.login_token,
//                                     )));
//                             _textFieldController.text = '';
//                           },
//                           child: Container(
//                               child: const Text(
//                                 '확인',
//                                 style: TextStyle(
//                                     fontSize: 30,
//                                     fontFamily: 'Dongle',
//                                     color: Colors.black),
//                               )),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.pop(context, 'cancel');
//                             _textFieldController.text = '';
//                           },
//                           child: const Text(
//                             '취소',
//                             style: TextStyle(
//                                 fontSize: 30,
//                                 fontFamily: 'Dongle',
//                                 color: Colors.black),
//                           ),
//                         )
//                       ],
//                     ),
//                   ],
//                 ));
//           },
//           child: Icon(Icons.add),
//           );
//   }
//
//   Stack buildStackBody(BuildContext context) {
//     return Stack(
//     children: <Widget>[
//       Column(children: <Widget>[
//         SizedBox(height: MediaQuery.of(context).size.height / 16),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Image(image: AssetImage("image/design/WhiteEllipseTop.png")),
//           ],
//         ),
//         SizedBox(height: MediaQuery.of(context).size.height / 4),
//         Row(
//           children: [
//             //SizedBox(width: 30,),
//             Image(image: AssetImage("image/design/WhiteEllipseBottom.png")),
//           ],
//         )
//       ]),
//       Column(
//         children: [
//           Container(
//             width: MediaQuery.of(context).size.width,
//             color: Colors.white70,
//             child: Text('학습 자료를 추가할 주제를 골라주세요', style: TextStyle(fontSize: 35, fontFamily: 'Dongle', color: Colors.green),
//             textAlign: TextAlign.center),),
//           Expanded(
//             child: GridView.builder(
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
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => AddNewFilePage(
//                                       textSubject:
//                                       learningMaterials[index].subject,
//                                       login_token: widget.login_token,
//                                     )));
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
//                                   image:
//                                       AssetImage(learningMaterials[index].imgPath),
//                                   width: MediaQuery.of(context).size.width / 4),
//                             ],
//                           ),
//                         )),
//                   );
//                 }
//                 ),
//           ),
//         ],
//       ),
//     ],
//   );
//   }
//
//
//   AppBar buildAppBar(BuildContext context) {
//     return AppBar(
//       elevation: 0.0,
//       backgroundColor: Color(0xffFED40B),
//       title: Text(
//         '새로운 자료 추가하기',
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
