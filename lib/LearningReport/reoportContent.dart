import 'package:flutter/cupertino.dart';

class ReportContent {
  final String title; // 6월 6일의 학습 리포트
  final String goodSentence;
  final String badSentence;
  final int score; // 오늘 하루 전체 점수 -> 이에 따른 학습 응원 메시지 송출

  ReportContent(
      {required this.title,
        required this.goodSentence,
        required this.badSentence,
        required this.score});

  factory ReportContent.fromJson(Map<String, dynamic> json){
    final String title = json['today'].toString() + '의 학습 리포트';
    return ReportContent(title: title, goodSentence: json['goodSentence'],
        badSentence :json['goodSentence'], score: json['score']);
  }
}