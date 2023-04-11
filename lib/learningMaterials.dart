class LearningMaterial {
  final String subject;
  int sentenceCnt = 0;
  final List<SentenceData> sentences;

  //final String videoPath;

  LearningMaterial(this.subject, this.sentences) {
    this.sentenceCnt = this.sentences.length;
    // sentence list어떻게 만들지 고민!
  }
}

class SentenceData {
  final String subject;
  final String sentence;
  final String videoPath;

  SentenceData(this.subject, this.sentence, this.videoPath);
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
  "food1",
  "food2",
  "food3",
  "food4",
  "food5"
];


List<String> exerciseSentenceVideoList = [
  "exercise1",
  "exercise2",
  "exercise3",
  "exercise4",
  "exercise5"
];


List<String> familySentenceVideoList = [
  "family1",
  "family2",
  "family3",
  "family4",
  "family5"
];


List<String> schoolSentenceVideoList = [
  "school1",
  "school2",
  "school3",
  "school4",
  "school5"
];

final List<SentenceData> foodSentences = List.generate(
    foodSentenceList.length,
    (idx) =>SentenceData("food", foodSentenceList[idx], "video/"+foodSentenceVideoList[idx]+".mp4")
);

final List<SentenceData> exerciseSentences = List.generate(
    foodSentenceList.length,
        (idx) =>SentenceData("exercise", exerciseSentenceList[idx], "video/"+exerciseSentenceVideoList[idx]+".mp4")
);

final List<SentenceData> familySentences = List.generate(
    foodSentenceList.length,
        (idx) =>SentenceData("family", familySentenceList[idx], "video/"+familySentenceVideoList[idx]+".mp4")
);

final List<SentenceData> schoolSentences = List.generate(
    foodSentenceList.length,
        (idx) =>SentenceData("school", schoolSentenceList[idx], "video/"+schoolSentenceVideoList[idx]+".mp4")
);
