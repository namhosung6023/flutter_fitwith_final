import 'package:fitwith/views/premium/models/model_checklist.dart';

/// 회원.
class Member {
  /// 남성.
  static const String MALE = 'MALE';

  /// 여성.
  static const String FEMALE = 'FEMALE';

  /// 이름.
  String name;

  /// 성별.
  String gender;

  /// 나이.
  int age;

  /// 프로필 사진.
  String url = 'assets/img_sample.png';

  /// 체크리스트.
  final List<Checklist> checklist = [];

  final List<String> commentList = [];

  Member(this.name, this.gender, this.age);
}
