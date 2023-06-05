import 'package:flutter/cupertino.dart';

import '../../SetCharacter/character.dart';

class LearningMaterialServer {
  String subject;
  String subjectKor;
  String imgPath;
  List<SentenceDataServer> sentences;
  int sentenceCnt = 0;

  //final String videoPath;

  LearningMaterialServer({required this.subject, required this.subjectKor, required this.sentences,  required this.imgPath}) {
    this.sentenceCnt = this.sentences!.length;
    // sentence list어떻게 만들지 고민!
  }

  // json data 처리
  factory LearningMaterialServer.fromJson(Map<String, dynamic> json, SelectedCharacter selectedCharacter){

    final List<dynamic> item = json['sentences'];
    final String subject = json['subject'];

    List<SentenceDataServer> SentenceDataList = item.map((item) => SentenceDataServer.fromJson(item, subject, selectedCharacter)).toList();

    return LearningMaterialServer(
        subject: json['subject'],
        subjectKor: json['subjectKor'],
        sentences: SentenceDataList,
        imgPath: json['subjectImg']);
  }
}

class SentenceDataServer {
  final String subject;
  final String sentence;
  final String videoPath;

  SentenceDataServer({required this.subject, required this.sentence, required SelectedCharacter selectedCharacter, required this.videoPath}) {
    // this.videoPath =
    //     "video/sentence/${this.subject}/${selectedCharacter.character.name}/" +
    //         video + ".mp4";
  }
  factory SentenceDataServer.fromJson(Map<String, dynamic> json, String subject, SelectedCharacter selectedCharacter){
    return SentenceDataServer(
      subject : json['subject'],
      sentence : json['sentence'],
      selectedCharacter : selectedCharacter,
      videoPath : json['videoPath'],
    );
  }
}

List<String> foodSentenceList = [
  "내가 제일 좋아하는 과일은 수박이에요",
  "나는 엄마랑 밥을 먹을 때 가장 행복해요",
  "나는 초콜릿과 사탕을 매우 좋아해요",
  "나는 피자와 핫도그를 좋아해요",
  "오늘 점심에는 치킨 너겟과 감자튀김을 먹을 거예요"
];

List<String> exerciseSentenceList = [
  "나는 놀이공원에서 롤러코스터를 탈 거예요",
  "나는 자전거를 타고 주변을 돌아다니면서 신나게 운동해요",
  "오늘 유치원에서 달리기를 했어요",
  "친구들과 축구를 하면 기분이 좋아져요",
  "나는 달리기를 잘해요"
];

List<String> familySentenceList = [
  "내가 가장 사랑하는 건 가족이에요",
  "엄마는 나를 사랑하세요",
  "아빠는 정말 멋있어요",
  "우리 가족은 다섯 명이에요",
  "저녁은 매일 가족들과 먹어요"
];

List<String> schoolSentenceList = [
  "나는 학교에 가는 게 재미있어요",
  "학교에 가면 친구들과 선생님이 있어요",
  "우리 학교에는 도서관이 있어요",
  "내일은 학교에 가는 날이에요",
  "친구들과 먹는 급식은 맛있어요"
];

List<String> foodSentenceVideoList = [
  "food0",
  "food1",
  "food2",
  "food3",
  "food4"
];

List<String> exerciseSentenceVideoList = [
  "exercise0",
  "exercise1",
  "exercise2",
  "exercise3",
  "exercise4"
];

List<String> familySentenceVideoList = [
  "family0",
  "family1",
  "family2",
  "family3",
  "family4"
];

List<String> schoolSentenceVideoList = [
  "school0",
  "school1",
  "school2",
  "school3",
  "school4",
];
//
// final List<SentenceData> foodSentences = List.generate(
//     foodSentenceList.length,
//         (idx) =>
//         SentenceData(
//             "food", foodSentenceList[idx], selectedCharacter,
//             foodSentenceVideoList[idx]));
//
// final List<SentenceData> exerciseSentences = List.generate(
//     foodSentenceList.length,
//         (idx) =>
//         SentenceData(
//             "exercise", exerciseSentenceList[idx], selectedCharacter,
//             exerciseSentenceVideoList[idx]));
//
// final List<SentenceData> familySentences = List.generate(
//     foodSentenceList.length,
//         (idx) =>
//         SentenceData(
//             "family", familySentenceList[idx], selectedCharacter,
//             familySentenceVideoList[idx]));
//
// final List<SentenceData> schoolSentences = List.generate(
//     foodSentenceList.length,
//         (idx) =>
//         SentenceData(
//             "school", schoolSentenceList[idx], selectedCharacter,
//             schoolSentenceVideoList[idx]));
//
// // local 구동을 위한 learningMaterial 객체 생성
// LearningMaterialServer food =
// new LearningMaterialServer(subject: "food", subjectKor: "음식", sentences: foodSentences, imgPath: "image/icon/icon_food.png");
// LearningMaterialServer exercise =
// new LearningMaterialServer(subject: "exercise", subjectKor:"운동", sentences: exerciseSentences, imgPath: "image/icon/icon_exercise.png");
// LearningMaterialServer family =
// new LearningMaterialServer(subject: "family",subjectKor: "가족", sentences: familySentences, imgPath: "image/icon/icon_family.png");
// LearningMaterialServer school =
// new LearningMaterialServer(subject: "school",subjectKor: "학교", sentences: schoolSentences, imgPath: "image/icon/icon_school.png");
//
// List<LearningMaterialServer> learningMaterials = [food, school, family, exercise];
// List<String> learningMaterialKorList = ["음식", "학교", "가족", "운동"];

// Server로 통신데이터 가져오는 과정이 필요함.
