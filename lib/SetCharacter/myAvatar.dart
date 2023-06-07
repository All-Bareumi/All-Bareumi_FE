import 'dart:io';
import 'package:flutter/material.dart';
import 'package:face_camera/face_camera.dart';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

import '../userDrawer/loadingDrawer.dart';
import 'loadingCharacter.dart';


class MyAvatar extends StatefulWidget {
  const MyAvatar({Key? key}) : super(key: key);

  @override
  State<MyAvatar> createState() => _MyAvatarState();
}
class _MyAvatarState extends State<MyAvatar> {
  File? _capturedImage;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    WidgetsFlutterBinding.ensureInitialized();

    await FaceCamera.initialize();
  }
  @override
  Widget build(BuildContext context) {
    // 텍스트 데이터 전달
    // 화면 사이즈
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xffFED40B),
        title: Text(
          "내 얼굴을 찍어주세요",
          style: TextStyle(
              color: Colors.black, fontFamily: 'Dongle', fontSize: 35),
        ),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            color: const Color(0xff5a4c0c),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Builder(builder: (context) {
        if (_capturedImage != null) {
          return Center(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.file(
                  _capturedImage!,
                  width: double.maxFinite,
                  fit: BoxFit.fitWidth,
                ),
                ElevatedButton(
                    onPressed: () => setState(() => _capturedImage = null),
                    child: const Text(
                      'Capture Again',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w700),
                    ))
              ],
            ),
          );
        }
        return SmartFaceCamera(
            autoCapture: true,
            defaultCameraLens: CameraLens.front,
            onCapture: (File? image) {
              setState(() => _capturedImage = image);
            },
            onFaceDetected: (Face? face) {
              //Do something
            },
            messageBuilder: (context, face) {
              if (face == null) {
                return _message('내 얼굴을 카메라 안에 위치시키세요');
              }
              if (!face.wellPositioned) {
                return _message('내 얼굴을 사각형의 중간에 위치시키세요');
              }
              return const SizedBox.shrink();
            });
      }),
    );
  }
  Widget _message(String msg) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 15),
    child: Text(msg,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 14, height: 1.5, fontWeight: FontWeight.w400)),
  );
}

class MyAvatarImageUploader extends StatefulWidget {
  const MyAvatarImageUploader(
      {Key? key, required this.login_token, required this.pageName, this.textSubject, required this.selectedCharacter})
      : super(key: key);
  final String login_token;
  final String pageName;
  final String selectedCharacter;
  final String? textSubject; // 이건 선택사항 (내 아바타를 생성할 땐 필요 없음)

  @override
  State<MyAvatarImageUploader> createState() => _MyAvatarImageUploaderState();
}

class _MyAvatarImageUploaderState extends State<MyAvatarImageUploader> {
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
      _showDialog(context, widget.login_token);
    }
  }

  Future<dynamic> _showDialog(BuildContext context, String login_token) {
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
                  print('내 아바타 사진을 성공적으로 업로드했습니다');
                  print(response.data);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context)=> LoadingCharacter(login_token: login_token, selectedCharacter : "myAvatar"),
                      )
                  );

                  //return response.data;

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
      endDrawer: LoadingDrawer(login_token: widget.login_token, selectedCharacter: widget.selectedCharacter),
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
