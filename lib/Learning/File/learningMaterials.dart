import 'package:flutter/cupertino.dart';
import 'package:capstone/SetCharacter/selectCharacter.dart';

import '../../SetCharacter/character.dart';
class LearningMaterial {
  final String subject;
  final String subjectKor;
  int sentenceCnt = 0;
  late String imgPath;
  final List<SentenceData> sentences;

  //final String videoPath;

  LearningMaterial(this.subject, this.subjectKor, this.sentences, String img) {
    this.sentenceCnt = this.sentences.length;
    this.imgPath = "image/icon/icon_" + img + ".png";
    // sentence list어떻게 만들지 고민!
  }
}

class SentenceData {
  final String subject;
  final String sentence;
  late String videoPath;

  SentenceData(this.subject, this.sentence, SelectedCharacter selectedCharacter,String video) {
    this.videoPath = "video/sentence/${this.subject}/${selectedCharacter.character.name}/" + video + ".mp4";
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

final List<SentenceData> foodSentences = List.generate(
    foodSentenceList.length,
    (idx) => SentenceData(
        "food", foodSentenceList[idx], selectedCharacter, foodSentenceVideoList[idx]));

final List<SentenceData> exerciseSentences = List.generate(
    foodSentenceList.length,
    (idx) => SentenceData(
        "exercise", exerciseSentenceList[idx], selectedCharacter, exerciseSentenceVideoList[idx]));

final List<SentenceData> familySentences = List.generate(
    foodSentenceList.length,
    (idx) => SentenceData(
        "family", familySentenceList[idx], selectedCharacter, familySentenceVideoList[idx]));

final List<SentenceData> schoolSentences = List.generate(
    foodSentenceList.length,
    (idx) => SentenceData(
        "school", schoolSentenceList[idx], selectedCharacter, schoolSentenceVideoList[idx]));

LearningMaterial food =
    new LearningMaterial("food", "음식", foodSentences, "food");
LearningMaterial exercise =
    new LearningMaterial("exercise", "운동", exerciseSentences, "exercise");
LearningMaterial family =
    new LearningMaterial("family", "가족", familySentences, "family");
LearningMaterial school =
    new LearningMaterial("school", "학교", schoolSentences, "school");

List<LearningMaterial> learningMaterials = [food, school, family, exercise];
List<String> learningMaterialKorList = ["음식", "학교", "가족", "운동"];
