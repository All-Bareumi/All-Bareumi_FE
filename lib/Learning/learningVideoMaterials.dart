class LearningVideoMaterial{
  final String title;
  final String titleKor;
  late String videoPath;
  late String imgPath;
  LearningVideoMaterial(this.title, this.titleKor, String video, String img){
    this.videoPath = "video/videoContents/" + video +".mp4";
    this.imgPath = "image/icon/" + img + ".png";
  }
}

LearningVideoMaterial babyShark = new LearningVideoMaterial("babyShark", "아기상어", "babyShark", "yellowShark");
LearningVideoMaterial theTreeFrog = new LearningVideoMaterial("theTreeFrog", "청개구리", "theTreeFrog", "theTreeFrog");

List<LearningVideoMaterial> learningVideoMaterials= [
  babyShark,
  theTreeFrog
];