import 'package:fitwith/views/premium/models/model_member.dart';
import 'package:flutter/cupertino.dart';

/// 프리미엄 저장소
class PremiumRepository with ChangeNotifier {
  /// 현재 선택된 회원.
  Member member;

  ///
  void selectMember(Member member) {
    this.member = member;
    notifyListeners();
  }

  ///
  void clearSelected() {
    this.member = null;
    notifyListeners();
  }
}
