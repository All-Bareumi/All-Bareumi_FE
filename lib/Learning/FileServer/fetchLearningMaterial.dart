// 서버에서 subject리스트를 받아와서 해당 subject별로 learningMaterials를
import 'dart:convert';
import 'dart:io';

import 'learningMaterialsServer.dart';
import 'package:http/http.dart' as http;
Future<List<LearningMaterialServer>> fetchLearningMaterials(String login_token, String selectedCharacter) async {
  final response = await http.get(Uri.parse('https://example.com/api/subjects'),
    headers:{ HttpHeaders.authorizationHeader :'Bearer ${login_token}'},
  ); // 서버에서 학습 파일 주제 모은 리스트있는 곳에 접근

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    final List<dynamic> subjects = jsonData['subjects'];

    List<LearningMaterialServer> learningMaterials = [];

    for (var subject in subjects) {
      LearningMaterialServer material = await fetchLearningMaterial(login_token, subject, selectedCharacter);
      learningMaterials.add(material);
    }

    return learningMaterials;
  } else {
    throw Exception('Failed to fetch subjects');
  }
}

Future<LearningMaterialServer> fetchLearningMaterial(String login_token, String subject, String selectedCharacter) async {
  var url = '$subject/${selectedCharacter}'; // 주제에 따른
  final response = await http.get(Uri.parse(url),
    headers:{ HttpHeaders.authorizationHeader :'Bearer ${login_token}'},
  );

  if (response.statusCode == 200) {
    //만약 서버가 ok응답을 반환하면, json을 파싱합니다
    print('응답 완료');
    print(json.decode(response.body));
    return LearningMaterialServer.fromJson(json.decode(response.body), selectedCharacter);
  } else {
    //만약 응답이 ok가 아니면 에러를 던집니다.
    throw Exception('정보를 불러오는데 실패했습니다');
  }
}
