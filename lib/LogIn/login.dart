import 'package:flutter/material.dart';
import '../SetCharacter/setCharacter.dart';
import '../SignUp/signUp.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFED40B),
      body: Builder(
        builder: (context){
          return GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus(); // 텍스트 필드 이외의 화면을 클릭했을 때 키보드 사라지기
            },
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 200,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //SizedBox(width: 80,),
                      Image(
                        image: AssetImage('image/logo/AppName.png'),
                      ),
                      Image(
                        image: AssetImage('image/logo/logo.png'),
                        width: 60,
                      )
                    ],
                  ),
                  Form(
                    child: Theme(
                      data: ThemeData(
                        primaryColor: Colors.black,
                        inputDecorationTheme: InputDecorationTheme(
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 30.0,
                            fontFamily: 'Dongle',
                          )
                        ),
                      ),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(60,200, 60, 0),
                          child: Column(
                            children: <Widget>[
                              TextField(
                                autofocus: true,
                                controller: idController,
                                decoration: InputDecoration(
                                  labelText: '아이디'
                                ),
                            keyboardType: TextInputType.text,
                                ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextField(
                            autofocus: true,
                            controller: pwController,
                            decoration: InputDecoration(
                            labelText: '비밀번호',
                          ),
                            keyboardType: TextInputType.text,
                            obscureText: true, // 비밀번호 입력 안보이게
                              ),
                              const SizedBox(
                                height: 60.0,
                              ),
                              ButtonTheme(
                                minWidth: 100.0,
                                height: 50.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: (){
                                        //DB에 있는 사용자 확인 등 구현
                                        //if(controller.text)
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context)=> SetCharacter(),
                                          )
                                        );
                                      },
                                      child: Text(
                                        '시작하기',
                                        style: TextStyle(color: Colors.black, fontFamily: 'Dongle', fontSize: 30),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: (){
                                        //DB에 있는 사용자 확인 등 구현
                                        //if(controller.text)
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext context)=> SignUp(),
                                            )
                                        );
                                      },
                                      child: Text(
                                        '회원가입',
                                        style: TextStyle(color: Colors.black, fontFamily: 'Dongle', fontSize: 30),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.grey[400],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      )
    );
  }
}
