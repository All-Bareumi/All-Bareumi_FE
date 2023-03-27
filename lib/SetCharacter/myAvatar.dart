import 'package:flutter/material.dart';
import 'characters.dart';
//List<Character> Characters= [];
class MyAvatar extends StatelessWidget {
  const MyAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFED40B),
      endDrawer: Drawer(),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xffFED40B),
        title: Text('내 아바타 생성',
          style: TextStyle(
              color: Colors.black,fontFamily: 'Dongle',fontSize: 35),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            color: const Color(0xff5a4c0c),
            onPressed: (){
              Navigator.pop(context);
            }
        ),
        actions: <Widget>[
          Builder(
              builder: (context) {
                return IconButton(
                  icon: Image(
                    image: AssetImage('image/logo/logo.png'),
                    width: 60,
                  ),
                  onPressed: ()=>Scaffold.of(context).openEndDrawer(),
                );
              }
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(60, 150, 20, 0),
          child: Text('카메라의 표시선에 얼굴을 맞추세요',
          style: TextStyle(fontFamily: 'Dongle', fontSize: 35),),
        ),
    );
  }
}
