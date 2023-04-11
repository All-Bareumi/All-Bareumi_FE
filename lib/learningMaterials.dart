class LearningMaterial{
  final String subject;
  int sentenceCnt = 0;
  final List<Sentence> sentences;
  //final String videoPath;

  LearningMaterial(this.subject, this.sentences){
    this.sentenceCnt = this.sentences.length;
    // sentence list어떻게 만들지 고민!
  }
}

class Sentence{
  final String subject;
  final String sentence;
  final String videoPath;
  Sentence(this.subject, this.sentence, this.videoPath);
}