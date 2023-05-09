import 'package:flutter/material.dart';

class AddTextPage extends StatelessWidget {
  const AddTextPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFED40B),
      appBar: buildAppBar(context),
      body: TextScreen(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Color(0xffFED40B),
      title: Text(
        '텍스트 붙여넣어 학습자료 만들기',
        style:
            TextStyle(color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
      ),
      centerTitle: true,
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          color: const Color(0xff5a4c0c),
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }
}

class TextScreen extends StatelessWidget {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              left: 30, right: 30, top: MediaQuery.of(context).size.height / 6),
          child: TextField(
              controller: myController,
              maxLines: 5,
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Dongle', fontSize: 30),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xfffef9ed),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(30)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent, width: 2),
                      borderRadius: BorderRadius.circular(30)))),
        ),
        InkWell(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Container(
                child: Text(
                  "완료",
                  style: TextStyle(
                      fontFamily: 'Dongle', fontSize: 45, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                width: MediaQuery.of(context).size.width / 4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color(0xffED5555)),
              ),
            ),
            onTap: () => showDialog(
                //실제로는 DB에 저장되고 이런 알림메시지는 보여주지 않을 예정
                context: context,
                builder: (context) {
                  return AlertDialog(
                      content: Text(
                    myController.text,
                    style: TextStyle(
                      fontSize: 35,
                      fontFamily: 'Dongle',
                    ),
                  ));
                }))
      ],
    );
  }
}
