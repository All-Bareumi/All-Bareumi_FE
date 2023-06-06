import 'dart:convert';
import 'dart:io';

import 'package:capstone/LearningReport/reoportContent.dart';
import 'package:http/http.dart' as http;

Future<List<ReportContent>> fetchReportList(String login_token) async {
  final response = await http.get(Uri.parse('https://example.com/api/subjects'),
    headers:{ HttpHeaders.authorizationHeader :'Bearer ${login_token}'},
  ); // 서버에서 학습 파일 주제 모은 리스트있는 곳에 접근

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    final List<dynamic> dates = jsonData['all_dates'];

    List<ReportContent> reportContents = [];

    for (var date in dates) {
      ReportContent reportContent = await fetchReportContent(login_token, date);
      reportContents.add(reportContent);
    }

    return reportContents;
  } else {
    throw Exception('Failed to fetch subjects');
  }
}
Future<ReportContent> fetchReportContent(String login_token, String date) async {
  var url = '$date'; // 날짜에 따른
  final response = await http.get(Uri.parse(url),
    headers:{ HttpHeaders.authorizationHeader :'Bearer ${login_token}'},
  );

  if (response.statusCode == 200) {
    //만약 서버가 ok응답을 반환하면, json을 파싱합니다
    print('응답 완료');
    print(json.decode(response.body));
    return ReportContent.fromJson(json.decode(response.body));
  } else {
    //만약 응답이 ok가 아니면 에러를 던집니다.
    throw Exception('정보를 불러오는데 실패했습니다');
  }
}