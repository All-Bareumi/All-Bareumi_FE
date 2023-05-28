// import 'package:capstone/SetCharacter/imageUploader.dart';
// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
// import '../userDrawer/loadingDrawer.dart';
// import '../SetCharacter/imagePicker.dart';
// import '../SetCharacter/selectCharacter.dart';
// import '../SetCharacter/myAvatar.dart';
//
// class SelectMyAvatar extends StatelessWidget {
//   const SelectMyAvatar({Key? key}) : super(key: key);
//   final String hexYellow ="FED40B";
//   final String hexGreen ="1AB846";
//   final String hexBlue ="1086fe";
//   final String hexRed ="ED5555";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffFED40B),
//       endDrawer: LoadingDrawer(),
//       appBar: buildAppBar(context),
//       body: Stack(
//         children: <Widget>[
//           Column(children: <Widget>[
//             SizedBox(height: MediaQuery.of(context).size.height / 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Image(image: AssetImage("image/design/WhiteEllipseTop.png")),
//               ],
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height / 4),
//             Row(
//               children: [
//                 Image(image: AssetImage("image/design/WhiteEllipseBottom.png")),
//               ],
//             )
//           ]),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               InkWell(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (BuildContext context) => MyAvatar(),
//                       )
//                   );
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(35.0),
//                   child: Center(
//                     child: Container(
//                       child: Text(
//                         '내 사진 찍기',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontFamily: 'Dongle',
//                           fontSize: 40,
//                           color: Colors.white,
//                         ),
//                       ),
//                       width: MediaQuery.of(context).size.width,
//                       height: MediaQuery.of(context).size.height / 7,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: HexColor(hexGreen)),
//                     ),
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (BuildContext context) => SetMyAvatar(),
//                       ));
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(35.0),
//                   child: Container(
//                     child: Text(
//                       '사진첩에서\n 내 사진 불러오기',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontFamily: 'Dongle',
//                         fontSize: 40,
//                         color: Colors.white,
//                       ),
//                     ),
//                     width: MediaQuery.of(context).size.width,
//                     height: MediaQuery.of(context).size.height / 7,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: HexColor(hexBlue)),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   AppBar buildAppBar(BuildContext context) {
//     return AppBar(
//       elevation: 0.0,
//       backgroundColor: Color(0xffFED40B),
//       title: Text(
//         '내 아바타 생성하기',
//         style:
//         TextStyle(color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
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
//
// }