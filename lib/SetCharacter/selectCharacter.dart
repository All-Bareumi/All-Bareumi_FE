import 'package:flutter/material.dart';
import 'characters.dart';
import 'loadingCharacter.dart';

// 이후 캐릭터 객체 생성후 처리하기
// 지금은 페이지 그리기 용.
List<String> charName = [
  '엘사',
  '안나',
  '크리스토프',
  '한스'
];

final List<Character> CharacterData= List.generate(
    charName.length, (idx) => Character(charName[idx], 'image/character'+ charName[idx]+'.png')
);

class SelectCharacter extends StatelessWidget {
  const SelectCharacter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFED40B),
      endDrawer: Drawer(),
      appBar: buildAppBar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left :30.0, right: 20.0),
              child: Row(
                children: <Widget>[
                  Text('엘사', style: TextStyle(fontSize: 40, fontFamily: 'Dongle'),),
                  SizedBox(width: 140,),
                  Text('안나', style: TextStyle(fontSize: 40, fontFamily: 'Dongle'),),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left :30.0, right: 20.0, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildCharacterButton('elsa',context),
                  SizedBox(width: 30),
                  buildCharacterButton('anna',context),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30,left :30.0, right: 20.0),
              child: Row(
                children: <Widget>[
                  Text('크리스토프', style: TextStyle(fontSize: 40, fontFamily: 'Dongle'),),
                  SizedBox(width: 100,),
                  Text('한스', style: TextStyle(fontSize: 40, fontFamily: 'Dongle'),),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left :20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildCharacterButton('kristoff',context),
                  SizedBox(width: 30),
                  buildCharacterButton('hans',context),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Color(0xffFED40B),
      title: Text('캐릭터 선택',
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
    );
  }

  InkWell buildCharacterButton(String name, BuildContext context ) {
    return InkWell(
      onTap: (){
        // 캐릭터 선택 이후 액션
        // 캐릭터 선택 확정 로딩페이지로 이동
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context)=> LoadingCharacter(),
            )
        );
        },
      child: Container(
        child:CircleAvatar(
          backgroundImage:AssetImage('image/character/'+name+'_face.png'),
          backgroundColor: Color(0xffFED40B) ,
          radius: 70,
        ),
      ),
    );
  }
}
