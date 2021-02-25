import 'package:fitwith/views/premium/models/model_checklist.dart';
import 'package:fitwith/views/premium/models/model_bodylog.dart';

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

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  int alarmCount = 0;

  /// 체크리스트.
  List<Checklist> checklist = [];

  List<String> commentList = [];

  List<BodyLog> bodyLog = [];

  Member(this.name, this.gender, this.age);
}
