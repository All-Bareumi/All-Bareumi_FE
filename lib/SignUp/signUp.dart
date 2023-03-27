import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('회원가입',
          style: TextStyle(
          color: Colors.black,fontFamily: 'Dongle',fontSize: 35
        ),
        ),
        backgroundColor: Color(0xffFED40B),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            color: const Color(0xff5a4c0c),
            onPressed: (){
              Navigator.pop(context);
            }
        ),
      ),

    );
  }
}
