import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class UserData {
  // 카카오 정보
  final User user;
  final String userName;
  final int userId;
  final String profileImg;


  // 올바르미 앱 사용자 정보
  final String degree;
  final String selectedCharacter;
  final int continue_day;
  late final int targetLearningAmountPerDay;
  final String current_reward;

  UserData(this.user, this.userName, this.userId, this.profileImg, this.degree, this.selectedCharacter, this.continue_day, this.targetLearningAmountPerDay, this.current_reward);
  //UserData(this.user, this.userName, this.userId, this.profileImg, this.nickname, this.selectedCharacter);
}