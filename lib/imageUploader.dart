import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

import 'userDrawer/loadingDrawer.dart';

class ImageUploader extends StatefulWidget {
  const ImageUploader(
      {Key? key, required this.login_token, required this.pageName, this.textSubject})
      : super(key: key);
  final String login_token;
  final String pageName;
  final String? textSubject; // 이건 선택사항 (내 아바타를 생성할 땐 필요 없음)

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  final String hexYellow = "FED40B";
  final String hexGreen = "1AB846";
  final String hexBlue = "1086fe";
  final String hexRed = "ED5555";

  XFile? _image; //이미지를 담을 변수 선언
  dynamic _sendImage; // 이미지 서버로 보낼 변수 선언
  final ImagePicker picker = ImagePicker(); //ImagePicker 초기화
  //이미지를 가져오는 함수
  Future getImage(ImageSource imageSource, BuildContext context) async {
    //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      //팝업 페이지 띄우기
      _sendImage = pickedFile.path;
      setState(() {
        _image = XFile(_sendImage); //가져온 이미지를 _image에 저장
      });
      print('이미지 화면에 띄우기');
    }
    if (_image != null) {
      _showDialog(context);
    }
  }

  Future<dynamic> _showDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('이 사진을 업로드할까요?'),
        actions: [
          ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                Navigator.of(context).pop();

                print('사진을 서버에 업로드 합니다.');
                var dio = new Dio();
                print(_sendImage);
                FormData formDataImg = FormData.fromMap({
                  'data': await MultipartFile.fromFile(_sendImage)
                }); // 여기서 image는 서버의 key값
                try {
                  dio.options.contentType = 'multipart/form-data';
                  dio.options.maxRedirects.isFinite;
                  dio.options.headers = {
                    HttpHeaders.authorizationHeader:
                        'Bearer ${widget.login_token}' // 이 형식으로 항상 넘겨주기
                  }; // login token
                  var response = await dio.post(
                    'http://localhost:8001/api/user/photos/upload',
                    data: formDataImg,
                  );
                  print('성공적으로 업로드했습니다');
                  print(response.data);
                  return response.data;
                } catch (e) {
                  print(e);
                }

              },
              child: Text('네')),
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(), child: Text('아니요')),
        ],
      ),
    );
  }

  Widget _buildPhotoArea() {
    return _image != null
        ? Container(
            width: 300,
            height: 300,
            child: Image.file(File(_image!.path)), //가져온 이미지를 화면에 띄워주는 코드
          )
        : Container(
            width: 300,
            height: 300,
            color: Colors.grey,
          );
  }

  Widget _buildButton() {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            getImage(ImageSource.camera,
                context); //getImage 함수를 호출해서 카메라로 찍은 사진 가져오기
            if (_image != null) {
              //_showDialog(context);
            }
          },
          child: Text(
            "카메라",
            style: TextStyle(fontFamily: 'Dongle', fontSize: 30),
          ),
          style: ElevatedButton.styleFrom(backgroundColor: HexColor(hexBlue)),
        ),
        SizedBox(width: 30),
        ElevatedButton(
          onPressed: () {
            getImage(
                ImageSource.gallery, context); //getImage 함수를 호출해서 갤러리에서 사진 가져오기
            if (_image != null) {
              //_showDialog(context);
            }
          },
          child: Text(
            "갤러리",
            style: TextStyle(fontFamily: 'Dongle', fontSize: 30),
          ),
          style: ElevatedButton.styleFrom(backgroundColor: HexColor(hexGreen)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFED40B),
      endDrawer: LoadingDrawer(login_token: widget.login_token),
      appBar: buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 100, width: double.infinity),
          _buildPhotoArea(),
          SizedBox(height: 50),
          _buildButton(),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Color(0xffFED40B),
      title: Text(
        '${widget.pageName}',
        style:
            TextStyle(color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
      ),
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          color: const Color(0xff5a4c0c),
          onPressed: () {
            Navigator.pop(context);
          }),
      actions: <Widget>[
        Builder(builder: (context) {
          return IconButton(
            icon: Image(
              image: AssetImage('image/logo/logo.png'),
              width: 60,
            ),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          );
        })
      ],
    );
  }
}
